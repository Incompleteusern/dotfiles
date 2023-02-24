set background=dark
set clipboard=unnamedplus
set completeopt=noinsert,menuone,noselect
set cursorline
set hidden
set inccommand=split
set mouse=a
set number
set splitright splitbelow
set title
set ttimeoutlen=0
set wildmenu
set expandtab
set shiftwidth=2
set tabstop=2

set mousemodel=extend

filetype plugin indent on
syntax on

set t_Co=256

" Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

call plug#begin()
    " Appearance
    Plug 'nvim-lualine/lualine.nvim'
    " Plug 'vim-airline/vim-airline'
    " Plug 'ryanoasis/vim-devicons'
    
    " Utilities
    Plug 'sheerun/vim-polyglot'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ap/vim-css-color'
    " Plug 'preservim/nerdtree'
    Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
    " Plug 'neoclide/coc.nvim',  {'branch': 'master', 'do': 'yarn install'}
    Plug 'plasticboy/vim-markdown'
    Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
    Plug 'nvim-tree/nvim-tree.lua'
    Plug 'akinsho/bufferline.nvim', { 'tag': 'v3.*' }
    " Git
    Plug 'airblade/vim-gitgutter'

    Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

colorscheme catppuccin

let NERDTreeShowHidden=1

nnoremap <C-c> :wqall<CR>
nnoremap <C-q> :bd<CR>
nnoremap <C-x> :NvimTreeToggle<CR>
nnoremap <C-t> :sp<CR>:terminal<CR>

set termguicolors
lua << EOF
require('tree')
require("bufferline").setup{
    options = {
        offsets = {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            padding = 1,
        },
    }
}
require("bubbles")
EOF
