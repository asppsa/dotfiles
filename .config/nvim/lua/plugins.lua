return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  --use 'scrooloose/nerdtree'
  use 'nvim-tree/nvim-tree.lua'

  use 'ap/vim-css-color'
  -- use 'dense-analysis/ale'
  -- use 'mfussenegger/nvim-lint'
  -- use 'mhartington/formatter.nvim'
  use {'jose-elias-alvarez/null-ls.nvim', requires = {'nvim-telescope/telescope-fzf-native.nvim'}}
  use 'editorconfig/editorconfig-vim'
  -- use 'itchyny/lightline.vim'
  use 'kamykn/popup-menu.nvim'
  use 'kamykn/spelunker.vim'
  -- use 'maximbaz/lightline-ale'
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use 'neovim/nvim-lspconfig'
  -- use 'sheerun/vim-polyglot'
  -- use 'tpope/vim-fugitive'
  -- use 'tpope/vim-rhubarb'
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }
  use {
      'ruifm/gitlinker.nvim',
      requires = 'nvim-lua/plenary.nvim',
  }
  -- use 'tyru/open-browser-github.vim'
  -- use 'tyru/open-browser.vim'
  -- use 'Quramy/vim-js-pretty-template'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use 'ThePrimeagen/vim-be-good'
  -- use 'nvim-lua/lsp-status.nvim'
  -- use 'ms-jpq/coq_nvim'
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = [[
      cmake \
        -S. \
        -Bbuild \
        -DCMAKE_BUILD_TYPE=Release && \
      cmake --build build --config Release && \
      cmake --install build --prefix build
    ]]
  }
  use {'tzachar/fuzzy.nvim', requires = {'nvim-telescope/telescope-fzf-native.nvim'}}
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }
  use {
    "ray-x/sad.nvim",
    requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
    config = function()
      require("sad").setup{}
    end,
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use {'tzachar/cmp-fuzzy-path', requires = {'hrsh7th/nvim-cmp', 'tzachar/fuzzy.nvim'}}

  -- Colour Schemes
  --use 'arcticicestudio/nord-vim'
  use 'artanikin/vim-synthwave84'
  use 'ayu-theme/ayu-vim'
  use 'cocopon/iceberg.vim'
  use {'dracula/vim', as = 'dracula'}
  use 'flrnprz/candid.vim'
  use 'haishanh/night-owl.vim'
  use 'jcherven/jummidark.vim'
  use 'morhetz/gruvbox'
  use 'sainnhe/edge'
  use 'sainnhe/vim-color-forest-night'
  use 'tomasr/molokai'
  use 'tpope/vim-vividchalk'
  use 'rubik/vim-base16-paraiso'
  -- nvim colour schemes
  use 'mhartington/oceanic-next'
  use 'Abstract-IDE/Abstract-cs'
  use 'rafamadriz/neon'
  --use 'marko-cerovac/material.nvim'
  --use 'bluz71/vim-nightfly-guicolors'
  use 'bluz71/vim-moonfly-colors'
  --use 'ChristianChiarulli/nvcode-color-schemes.vim'
  -- use 'folke/tokyonight.nvim'
  use 'sainnhe/sonokai'
  use 'tanvirtin/monokai.nvim'
  use 'sainnhe/everforest'
  use({
    'glepnir/zephyr-nvim',
    requires = { 'nvim-treesitter/nvim-treesitter', opt = true },
  })
  use({ 'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      require("rose-pine").setup({
        variant = 'moon'
      })
    end,
  })
end)
