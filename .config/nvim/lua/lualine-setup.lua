require('lualine').setup({
  options = {
    theme = 'rose-pine-alt',
    disabled_filetypes = {
      statusline = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles', 'AgenticDiagnostics', 'AgenticTodos' },
      winbar = { 'AgenticChat', 'AgenticInput', 'AgenticCode', 'AgenticFiles', 'AgenticDiagnostics', 'AgenticTodos' },
    }
  }
})
