local mason = require 'mason'
local lspconfig = require 'lspconfig'
-- local lsp_status = require('lsp-status')
-- local coq = require 'coq'
local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local null_ls = require('null-ls')
local command_resolver = require('null-ls.helpers.command_resolver')

-- lsp_status.register_progress()

mason.setup {
  ui = {
      icons = {
          server_installed = "✓",
          server_pending = "➜",
          server_uninstalled = "✗"
      }
  }
}

require("mason-lspconfig").setup()

null_ls.setup({
  debug = true,
  default_timeout = 10000,
  sources = {
    -- general
    null_ls.builtins.formatting.trim_newlines,
    null_ls.builtins.formatting.trim_whitespace,

    --lua
    null_ls.builtins.diagnostics.luacheck.with({
      -- added "-g" to ignore warnings about globals
      args = {"-g", "--formatter", "plain", "--codes", "--ranges", "--filename", "$FILENAME", "-"}
    }),
    null_ls.builtins.formatting.stylua,

    -- javascript
    --null_ls.builtins.code_actions.eslint.with({prefer_local = "node_modules/.bin"}),
    --null_ls.builtins.diagnostics.eslint.with({prefer_local = "node_modules/.bin"}),
    --null_ls.builtins.formatting.eslint.with({prefer_local = "node_modules/.bin"}),

    -- ruby
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop.with({
      --prefer_local = "bin",
      args = { "--auto-correct-all", "-f", "quiet", "--stderr", "--stdin", "$FILENAME" }
    }),

    -- prettier
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {'handlebars', 'yaml', 'markdown'}
    }),

    -- elixir
    null_ls.builtins.diagnostics.credo,
    null_ls.builtins.formatting.mix,

    -- shell
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,

    -- css
    null_ls.builtins.formatting.stylelint.with({dynamic_command = command_resolver.from_node_modules()})
  }
})

local function setup(server, config)
  config = config or {}
  config.on_attach = function (_client)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {buffer = true})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer = true})
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer = true})
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer = true})
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, {buffer = true})
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, {buffer = true})
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, {buffer = true})
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, {buffer = true})
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, {buffer = true})
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, {buffer = true})
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, {buffer = true})
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer = true})
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set({'n', 'v'}, '<space>f', function()
      vim.cmd [[
        if exists(":EslintFixAll")
          EslintFixAll
        endif
      ]]

      vim.lsp.buf.format({
        async = true,
        filter = function (client)
          -- Some LSPs do dumb things, so we filter them out
          for _, lsp in ipairs({'tsserver'}) do
            if lsp == client.name then return false end
          end
          return true
        end
      })
    end, {buffer = true})
  end

  -- config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, lsp_status.capabilities)
  config.capabilities = vim.tbl_extend('keep', config.capabilities or {}, cmp_capabilities)
  lspconfig[server].setup(config)
end

setup('tsserver', {
  init_options = {
    preferences = {
      disableSuggestions = true;
    };
  };
})
setup 'solargraph'
setup 'elixirls'
setup 'ember'
-- setup('glint', {
--   cmd = {'yarn', '-s', 'glint-language-server'}
-- })
setup 'eslint'

-- causing too much consternation
-- setup 'syntax_tree'

-- setup 'typeprof'
