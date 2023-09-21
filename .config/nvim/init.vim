" Basic indenting rules
set expandtab
set shiftwidth=2
set softtabstop=2

" Hide rather than closing buffers
set hidden

" Enable mouse interaction
set mouse=nv

let g:vim_markdown_folding_disabled = 1

" Load plugins using packer
lua require 'plugins'

" Reload packer whenever the file is saved
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end

" Setup other lua stuff
lua require 'treesitter-setup'
lua require 'telescope-setup'
lua require 'cmp-setup'
lua require 'lsp-setup'
lua require 'nvim-tree-setup'
lua require 'lualine-setup'
lua require 'git-setup'
if exists("g:neovide")
  lua require "neovide-setup"
endif

"""
""" Appearance
"""

set termguicolors      " enable true colors support
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
"let ayucolor="dark"   " for dark version of theme
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:everforest_background = 'hard'
"let g:sonokai_style = 'andromeda'
"g:everforest_enable_italic = 1
colorscheme rose-pine
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr guibg=NONE ctermbg=NONE
"hi SignColumn guibg=NONE ctermbg=NONE
"hi EndOfBuffer guibg=NONE ctermbg=NONE

" This gets rid of "-- INSERT --"
set noshowmode

# Enable spellchecking
set spell

" deletes the last newline in the file
map <M-S-x> :!perl -pi -e 'chomp if eof' %<CR>

" tab commands
nmap <leader>tn :tabnext<CR>
nmap <leader>tp :tabprevious<CR>
nmap <leader>to :tabnew<CR>
nmap <leader>tc :tabclose<CR>
