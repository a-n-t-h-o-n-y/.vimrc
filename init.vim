scriptencoding utf-8
let encoding='utf-8'
set nocompatible
syntax on
filetype plugin on
set hidden
set ignorecase
set history=100
set updatetime=250
set sessionoptions="blank,buffers,sesdir,folds,help,tabpages,winsize"

set wrap
set number
set textwidth=80
set colorcolumn=80
let &colorcolumn=join(range(81,999),",")
set formatoptions+=t
set number relativenumber
set ruler
set scrolloff=6
set lazyredraw
set autoread
set linebreak
set completeopt-=preview
set guicursor= 
set mouse=a
" set cursorline
" set cursorcolumn
set noic

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " Tabs as spaces
set autoindent
set smartindent

set wildmenu
set wildmode=list:longest,full
set wildcharm=<Tab>

" Folding
set foldmethod=syntax
set nofoldenable

" Install vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install plugins with :PlugInstall

call plug#begin('~/.vim/plugged')
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rhysd/vim-clang-format'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/goyo.vim' | Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'majutsushi/tagbar'
Plug 'mbbill/undotree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'milkypostman/vim-togglelist'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.vim'
" Plug 'benekastah/neomake'
call plug#end()

" Vertical Split Thin Line
autocmd! ColorScheme * hi VertSplit cterm=NONE ctermbg=NONE ctermfg=247
autocmd! ColorScheme * hi VertSplit gui=NONE   guibg=NONE   guifg=247

" Terminal Colors
set termguicolors
colorscheme one-light
set background=light

" Exit insert mode on nvim terminal
tnoremap jk <C-\><C-n>

" Build
nnoremap <F9> :make<CR>
set makeprg=clang++\ -g\ -std=c++17\ %\ &&\ ./a.out
" set makeprg=make\ -j4\ -C\ build/\ $*

" Insert Date
nnoremap <F5> "=strftime("%b %d, %Y")<CR>P

" Tagbar
nmap <leader>tb :TagbarToggle<CR>

" Window Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Save shortcut
nnoremap <Leader>s :update<CR>

" Esc shortcut
inoremap jk <Esc>

" Bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search and replace under selection
vnoremap <Leader>r :s/

" Search and replace entire buffer
nnoremap <Leader>r :%s/

" Open/Reload .vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>v :source $MYVIMRC<CR>

" Invisible Characters
set list
let &listchars = "tab:\u2192 ,extends:>,precedes:<,trail:\u00b7" " ,eol:\u00ac
let &showbreak = '>'

" YouCompleteMe Config
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 1
let g:ycm_server_python_interpreter = '/usr/bin/python3'
" let g:ycm_add_preview_to_completeopt = 1
" set completeopt=longest,menuone

" CtrlP Config
let g:ctrlp_dotfiles = 1
nnoremap <Leader>b :CtrlPBuffer<CR>

" GitGutter Config
let g:gitgutter_realtime = 1

" Undotree Config
nnoremap <Leader>u :UndotreeToggle<cr>
let g:undotree_DiffAutoOpen = 0
" autocmd VimEnter * UndotreeToggle

" Clang Format Config
let g:clang_format#code_style = 'Chromium'
let g:clang_format#style_options = { "Standard" : "C++11" }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Autoformat(Python)
autocmd FileType python nnoremap <buffer><Leader>f :Autoformat<CR>
autocmd FileType python vnoremap <buffer><Leader>f :Autoformat<CR>
let g:formatter_yapf_style = 'chromium'

" Enhanced Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Goyo/Limelight Config
" let g:goyo_linenr=1
let g:goyo_height = '100%'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" NERD Commenter Config
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left
" instead of following code indentation
let g:NERDDefaultAlign = 'left'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Remove -a to respect .gitignore
  let g:ctrlp_user_command = 'ag %s -l -nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Auto Commenting turned off
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Neomake Config - Clang Tidy
" nnoremap <Leader>nm :Neomake<CR>
" let g:neomake_cpp_enabled_makers =  ['clangtidy']
" let g:neomake_cpp_clangtidy_args = ['-checks=*,-llvm-include-order,
"             \-google-runtime-references,-llvm-header-guard,
"             \-fuchsia-default-arguments', '-extra-arg=-std=c++14',
"             \'-header-filter=.*']
