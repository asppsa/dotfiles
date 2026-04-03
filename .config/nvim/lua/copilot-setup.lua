if os.getenv("USE_NVIM_COPILOT") then
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false }
  })

  require("codecompanion").setup({
    interactions = {
      chat = {
        adapter = "opencode"
      },
      inline = {
        adapter = "copilot"
      },
      cli = {
        agent = "opencode",
        agents = {
          opencode = {
            cmd = "opencode",
            args = {},
            description = "OpenCode CLI Agent"
          },
          copilot = {
            cmd = "copilot",
            args = {},
            description = "Copilot CLI Agent"
          }
        }
      }
    }
  })
end
