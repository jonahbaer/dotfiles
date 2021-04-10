set backspace=indent,eol,start
set suffixes+=.aux,.bbl,.blg,.brf,.cb,.dvi,.idx,.ilg,.ind,.inx,.jpg,.log,.out,.png,.toc
set suffixes-=.h
set suffixes-=.obj

" Begin Customizations

set ruler
set number relativenumber
set colorcolumn=80
filetype on
filetype plugin on
filetype indent on
syntax on
syntax enable
set laststatus=2
set showtabline=2
set updatetime=1000

set path+=**
set wildmenu

set termguicolors
" idk why this works for st (set termguicolors should just work)
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" my custom commands
" opens pdf of some file (latex, markdown, etc.) in zathura
command ShowPDF !zathura %:r.pdf &


" VIM PLUG
call plug#begin('~/.config/nvim/plugged')

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'tjdevries/nlua.nvim'
Plug 'tjdevries/plenary.nvim'

" linting
Plug 'dense-analysis/ale'

" tpope
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'

" language stuff
Plug 'rust-lang/rust.vim'

" A E S T H E T I C
Plug 'airblade/vim-gitgutter'
Plug 'majutsushi/tagbar'
Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

call plug#end()


" lsp
lua require('lua_config')
autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" ALE


" TAGBAR
nmap <F8> :TagbarToggle<CR>


" GRUVBOX
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark

" ZENBURN
" colors zenburn

" VIM-AIRLINE
let g:airline_theme='zenburn'
let g:airline_powerline_fonts=1
let g:airline#extensions#ale#enabled=1


" NERDTree
map <F7> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" rust
let g:rustfmt_autosave = 1