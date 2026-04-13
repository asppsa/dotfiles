local blink = require('blink.cmp')

local default = { 'lsp', 'path', 'snippets', 'buffer' }

blink.setup({
  snippets = { preset = 'luasnip' },
  sources = {
    default = default,
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
