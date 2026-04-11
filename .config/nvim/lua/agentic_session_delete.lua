local Logger = require("agentic.utils.logger")

--- @class agentic.SessionDelete
local SessionDelete = {}

--- @param current_session agentic.SessionManager
--- @param on_delete fun()
local function with_current_session_check(current_session, on_delete)
    if current_session and current_session.session_id then
        vim.ui.select({
            "Cancel",
            "Delete anyway",
        }, {
            prompt = "Session is currently active. Delete anyway?",
        }, function(choice)
            if choice == "Delete anyway" then
                on_delete()
            end
        end)
    else
        on_delete()
    end
end

--- Show ACP session picker for deletion
--- @param sessions agentic.acp.SessionInfo[]
--- @param current_session agentic.SessionManager
local function show_acp_picker(sessions, current_session)
    local items = {}
    for _, s in ipairs(sessions) do
        local date = s.updatedAt and s.updatedAt:sub(1, 16):gsub("T", " ")
            or "unknown date"
        local title = s.title or "(no title)"
        table.insert(items, {
            display = string.format("%s - %s", date, title),
            session_id = s.sessionId,
            title = s.title,
            updated_at = date,
        })
    end

    vim.schedule(function()
        vim.ui.select(items, {
            prompt = "Select session to delete:",
            format_item = function(item)
                return item.display
            end,
        }, function(choice)
            if not choice then
                return
            end

            with_current_session_check(current_session, function()
                -- Try to delete via ACP first, fallback to CLI
                local caps = current_session.agent.agent_capabilities
                if caps
                    and caps.sessionCapabilities
                    and caps.sessionCapabilities.delete
                then
                    current_session.agent:delete_session(choice.session_id, function(result, err)
                        if err then
                            Logger.notify(
                                "Failed to delete session: " .. (err.message or "unknown error"),
                                vim.log.levels.ERROR
                            )
                            return
                        end
                        Logger.notify("Session deleted: " .. choice.title, vim.log.levels.INFO)
                        -- Show picker again for multi-delete
                        SessionDelete.show_picker(current_session)
                    end)
                else
                    -- Fallback to opencode CLI
                    local cmd = { "opencode", "session", "delete", choice.session_id }
                    vim.fn.system(cmd)
                    local exit_code = vim.v.shell_error
                    if exit_code == 0 then
                        Logger.notify("Session deleted: " .. choice.title, vim.log.levels.INFO)
                    else
                        Logger.notify(
                            "Failed to delete session (exit code " .. exit_code .. ")",
                            vim.log.levels.ERROR
                        )
                    end
                    -- Show picker again for multi-delete
                    SessionDelete.show_picker(current_session)
                end
            end)
        end)
    end)
end

--- Show session picker and delete selected session
--- @param current_session agentic.SessionManager
function SessionDelete.show_picker(current_session)
    local cwd = vim.fn.getcwd()
    current_session.agent:when_ready(function()
        current_session.agent:list_sessions(cwd, function(result, err)
            if err or not result then
                Logger.notify(
                    "Failed to list sessions: "
                        .. (err and err.message or "unknown error"),
                    vim.log.levels.WARN
                )
                return
            end

            local sessions = result.sessions
            if not sessions or #sessions == 0 then
                Logger.notify("No saved sessions found", vim.log.levels.INFO)
                return
            end

            show_acp_picker(sessions, current_session)
        end)
    end)
end

return SessionDelete
