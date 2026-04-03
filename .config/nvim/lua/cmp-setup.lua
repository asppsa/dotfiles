local blink = require('blink.cmp')

local default = { 'lsp', 'path', 'snippets', 'buffer' }
if os.getenv("USE_NVIM_COPILOT") then
  default = { 'lsp', 'copilot', 'path', 'snippets', 'buffer' }
end

blink.setup({
  snippets = { preset = 'luasnip' },
  sources = {
    default = default,
    providers = {
      copilot = {
        name = "copilot",
        module = "blink-copilot",
        score_offset = 100,
        async = true,
      }
    }
  },
  keymap = {
    ['<Tab>'] = { 'select_and_accept', 'fallback' },
    ['<S-Tab>'] = false,
    ['<C-CR>'] = { 'select_and_accept', 'fallback' }
  },
  cmdline = {
    completion = { menu = { auto_show = true } },
    keymap = {
      ['<Tab>'] = { 'select_and_accept', 'fallback' },
      ['<S-Tab>'] = false,
      ['<C-CR>'] = { 'accept_and_enter', 'fallback' }
    }
  },
})
