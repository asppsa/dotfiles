local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  'nvim-tree/nvim-tree.lua',

  -- 'ap/vim-css-color',
  { 
    'NvChad/nvim-colorizer.lua',
    config = function ()
      require 'colorizer'.setup()
    end
  },
  'editorconfig/editorconfig-vim',
  -- 'itchyny/lightline.vim'
  'kamykn/popup-menu.nvim',
  -- 'kamykn/spelunker.vim'
  -- 'maximbaz/lightline-ale'
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  'neovim/nvim-lspconfig',
  {
    'creativenull/efmls-configs-nvim',
    version = 'v1.x.x', -- version is optional, but recommended
    dependencies = { 'neovim/nvim-lspconfig' },
  },
  -- 'sheerun/vim-polyglot'
  'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb'
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  },
  {
    'tanvirtin/vgit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
      'ruifm/gitlinker.nvim',
      dependencies = 'nvim-lua/plenary.nvim'
  },
  -- 'tyru/open-browser-github.vim'
  -- 'tyru/open-browser.vim'
  -- 'Quramy/vim-js-pretty-template'
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'kchmck/vim-coffee-script',
  {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzy-native.nvim'},
  },
  'ThePrimeagen/vim-be-good',
  {'tzachar/fuzzy.nvim', dependencies = {'romgrk/fzy-lua-native'}},
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to the default settings
        -- refer to the configuration section below
      }
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  },
  {
    "ray-x/sad.nvim",
    dependencies = { "ray-x/guihua.lua", build = "cd lua/fzy && make" },
    config = function()
      require("sad").setup{}
    end
  },
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  },
  {
    'nvim-pack/nvim-spectre',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },

  -- completion
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/nvim-cmp',
  {'tzachar/cmp-fuzzy-path', dependencies = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}},
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot-setup")
  --   end,
  -- },

  -- Colour Schemes
  --'arcticicestudio/nord-vim'
  'artanikin/vim-synthwave84',
  'ayu-theme/ayu-vim',
  'cocopon/iceberg.vim',
  {'dracula/vim', name = 'dracula'},
  'flrnprz/candid.vim',
  'haishanh/night-owl.vim',
  'jcherven/jummidark.vim',
  'morhetz/gruvbox',
  'sainnhe/edge',
  'sainnhe/vim-color-forest-night',
  'tomasr/molokai',
  'tpope/vim-vividchalk',
  'rubik/vim-base16-paraiso',
  -- nvim colour schemes
  'mhartington/oceanic-next',
  'Abstract-IDE/Abstract-cs',
  'rafamadriz/neon',
  --'marko-cerovac/material.nvim'
  --'bluz71/vim-nightfly-guicolors'
  'bluz71/vim-moonfly-colors',
  --'ChristianChiarulli/nvcode-color-schemes.vim'
  -- 'folke/tokyonight.nvim'
  'sainnhe/sonokai',
  'tanvirtin/monokai.nvim',
  'sainnhe/everforest',
  {
    'glepnir/zephyr-nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },
  { 'rose-pine/neovim',
    name = 'rose-pine',
    config = function()
      require("rose-pine").setup({
        variant = 'moon'
      })
    end
  }
})
