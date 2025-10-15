local mason = require 'mason'
local mason_registry = require 'mason-registry'
local lspconfig = require 'lspconfig'

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

local languages = vim.tbl_extend(
  'force',
  require('efmls-configs.defaults').languages(),
  {
    bash = { require('efmls-configs.linters.shellcheck') },
    yaml = { require('efmls-configs.formatters.prettier') },
  }
)

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

local function setup(server, config)
  config = config or {}
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end

setup('cspell_ls', {
  cmd = {
    'cspell-lsp',
    '--stdio',
    '--config',
    os.getenv('HOME') .. '/.config/cspell.json'
  }
})

setup('efm', efmls_config)
setup('ts_ls', {
  init_options = {
    preferences = {
      disableSuggestions = true;
    };
  };
})
setup 'solargraph'

setup('elixirls', {
  cmd = { os.getenv('HOME') .. '/.local/share/nvim/mason/packages/elixir-ls/language_server.sh' }
})

setup 'ember'
-- setup('glint', {
--   cmd = {'yarn', '-s', 'glint-language-server'}
-- })
setup 'eslint'
setup 'lua_ls'
setup 'coffeesense'
setup('rubocop', {
  cmd = {'bundle', 'exec', 'rubocop', '--lsp'}
})
setup 'rust_analyzer'

-- causing too much consternation
-- setup 'syntax_tree'

-- setup 'typeprof'

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
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
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
    vim.keymap.set({'n', 'v'}, '<space>f', function()
      vim.cmd [[
        if exists(":EslintFixAll")
          EslintFixAll
        endif
      ]]

      vim.lsp.buf.format({
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
})
