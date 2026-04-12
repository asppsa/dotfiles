local agentic = require('agentic')
local SessionDelete = require('agentic_session_delete')
local SessionRegistry = require('agentic.session_registry')

agentic.setup({
  provider = "opencode-acp",
  acp_providers = {
    ['opencode-acp'] = {
      default_mode = 'plan'
    }
  },

  headers = {
    chat = {
      title = "AI Chat",
      suffix = nil,
    },
    input = {
      title = "Prompt",
      suffix = nil
    },
    code = {
      title = "Selected Code",
      suffix = nil
    },
    files = {
      title = "Referenced Files",
      suffix = nil
    },
    diagnostics = {
      title = "Diagnostics"
    },
    todos = {
      title = "TODOs"
    }
  },

  spinner_chars = {
    generating = {"▘", "▚", "▞", "▟", "▛", "▜", "▙", "▚", "▞", "█", "░", "▒", "▓", " "},
    thinking = {"♚", "█"},
    searching = vim.tbl_map(vim.fn.nr2char, {0xee06, 0xee07, 0xee08, 0xee09, 0xee0a, 0xee0b})
    -- busy = { "⡀", "⠄", "⠂", "⠁", "⠈", "⠐", "⠠", "⢀", "⣀", "⢄", "⢂", "⢁", "⢈", "⢐", "⢠", "⣠", "⢤", "⢢", "⢡", "⢨", "⢰", "⣰", "⢴", "⢲", "⢱", "⢸", "⣸", "⢼", "⢺", "⢹", "⣹", "⢽", "⢻", "⣻", "⢿", "⣿", },
  },

  diagnostic_icons = {
    error = "X",    -- Diagnostic severity: error
    warn = "▲",     -- Diagnostic severity: warning
    info = "●",      -- Diagnostic severity: information
    hint = "◆",     -- Diagnostic severity: hint
  },

  status_icons = {
    pending = "***",      -- Tool call awaiting execution
    in_progress = "...",  -- Tool currently executing
    completed = "∎",    -- Tool executed successfully
    failed = "X",       -- Tool execution failed
  },

  permission_icons = {
    allow_once = "◉",    -- Allow this execution only
    allow_always = "●",  -- Allow all future executions
    reject_once = "◎",    -- Reject this execution only
    reject_always = "○",  -- Reject all future executions
  },

  chat_icons = {
    user = "▶ ",    -- Icon shown for user messages
    agent = "◀ ",  -- Icon shown for agent/AI messages
  },

  message_icons = {
    thinking = "♚",   -- Shown when the agent is thinking/reasoning
    finished = "∎",   -- Shown when the interaction completes successfully
    stopped = "■",     -- Shown when the user cancels the generation
    error = "X",      -- Shown when the interaction ends with an error
  },
})

vim.keymap.set({ "n", "v", "i" }, "<C-\\>", function() agentic.toggle() end, { desc = "Toggle Agentic Chat" })
vim.keymap.set({ "n", "v" }, "<C-'>", function() agentic.add_selection_or_file_to_context() end,
  { desc = "Add file or selection to Agentic to Context" })
vim.keymap.set({ "n", "v", "i" }, "<C-,>", function() agentic.new_session() end, { desc = "New Agentic Session" })
vim.keymap.set({ "n", "v", "i" }, "<A-i>r", function() agentic.restore_session() end,
  { desc = "Agentic Restore session", silent = true })
local function delete_session()
  SessionRegistry.get_session_for_tab_page(nil, function(session)
    SessionDelete.show_picker(session)
  end)
end
vim.keymap.set({ "n", "v", "i" }, "<A-i>d", delete_session,
  { desc = "Agentic Delete session", silent = true })
vim.keymap.set("n", "<leader>ad", function() agentic.add_current_line_diagnostics() end,
  { desc = "Add current line diagnostic to Agentic" })
vim.keymap.set("n", "<leader>aD", function() agentic.add_buffer_diagnostics() end,
  { desc = "Add all buffer diagnostics to Agentic" })

-- configure for rose pine
require("rose-pine").setup({
  highlight_groups = {
    AgenticTitle = { fg = "subtle", bg = "surface" },
    AgenticStatusPending = { bg = "foam", fg = "foam", blend = 15 },
    AgenticStatusCompleted = { bg = "gold", fg = "gold", blend = 25 },
    AgenticStatusFailed = { bg = "love", fg = "love", blend = 15 },
  }
})

-- vim.api.nvim_set_hl(0, "AgenticDiffDelete", { link = "DiffDelete" })
-- vim.api.nvim_set_hl(0, "AgenticDiffAdd", { link = "DiffAdd" })
-- vim.api.nvim_set_hl(0, "AgenticDiffDeleteWord", { bg = "#9a3c3c", bold = true })
-- vim.api.nvim_set_hl(0, "AgenticDiffAddWord", { bg = "#155729", bold = true })
-- vim.api.nvim_set_hl(0, "AgenticCodeBlockFence", { link = "Directory" })
-- vim.api.nvim_set_hl(0, "AgenticTitle", { bg = "foam", fg = "base", bold = true })
-- vim.api.nvim_set_hl(0, "AgenticThinking", { link = "Comment" })
