scriptencoding utf-8
let encoding='utf-8'
filetype on
set nocompatible
syntax enable " Turn on syntax highlighting
set hidden " Leave hidden buffers open  
set history=100
set number
set updatetime=250
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set colorcolumn=80
set ruler
set so=7
set lazyredraw
set autoread
set softtabstop=4   " Space count for tab key in INSERT mode
set smarttab        " When off, <Tab> will not inserts spaces in front of a line
cd ~/Documents/C++/
set wrap
set linebreak

" Tabs converted to spaces for Indent plugin
set expandtab

if $TERM == "xterm-256color"
  set t_Co=256
endif

call plug#begin('~/.vim/plugged')

" Install vim-plug with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

"Install with :PlugInstall
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'majutsushi/tagbar'
Plug 'valloric/youcompleteme'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'rhysd/vim-clang-format'
Plug 'raimondi/delimitmate'
Plug 'luochen1990/rainbow'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'benekastah/neomake'
Plug 'critiqjo/lldb.nvim'
Plug 'junegunn/goyo.vim'
Plug 'jonathanfilip/vim-lucius'

call plug#end()

" Color Theme Config
colorscheme lucius
LuciusBlackHighContrast

set statusline=%{fugitive#statusline()}
set statusline+=%#warningmsg#

" Airline Config
let g:airline_powerline_fonts = 0
let g:airline_theme='lucius'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%t'
let g:airline_section_y = ''
let g:airline_section_x = '' 

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_right_sep = '◀'
let g:airline_left_sep = '▶'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.branch = ''
let g:airline_symbols.paste = '∥'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Tagbar Config
nmap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_compact = 1

" YouCompleteMe Config
let g:ycm_global_ycm_extra_conf =
    \ '~/.vim/plugged/youcompleteme/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0

" CtrlP Config
let g:ctrlp_dotfiles = 1
" nnoremap <C-S-P> :CtrlPTag<cr>
" nnoremap <C-P> :CtrlPMixed<cr>

" NERDTree Config
nnoremap <leader>nt :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeShowHidden=1
let NERDTreeHijackNetrw=1

" GitGutter Config
let g:gitgutter_realtime = 1

" Clang Format Config
let g:clang_format#code_style = 'Chromium'
let g:clang_format#style_options = { "Standard" : "C++11" }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" Rainbow Parenthesis Config
let g:rainbow_active = 1

" Easy Motion Config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Smooth Scroll Config
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" NERD Commenter Config
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left
" instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Neomake Config
" autocmd! BufWritePost * Neomake
let g:neomake_cpp_enabled_makers =  ['clangtidy']
let g:neomake_cpp_clangtidy_args = ['-checks=*', '-header-filter=.*']

" Startup Plugins
autocmd VimEnter * NERDTree
" autocmd FileType * nested :call tagbar#autoopen(0)
" autocmd BufEnter * nested :call tagbar#autoopen(0)
autocmd VimEnter * wincmd p

" Auto Commenting turned off
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Open/reload vim
nnoremap <leader>ev :edit $MYVIMRC<CR>  
nnoremap <leader>sv :source $MYVIMRC<CR>     

set completeopt-=preview

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" LLDB maps
nnoremap <F8> :LL step<CR>
nnoremap <F9> :LL next<CR>
nnoremap <F7> <Plug>LLBreakSwitch

" Syntastic Config
" let g:syntastic_cpp_checkers = ['clang_tidy'] 
" let g:syntastic_cpp_check_header = 1
" let g:syntastic_cpp_auto_refresh_includes = 1
" let g:syntastic_cpp_clang_tidy_args = '-checks=*'
" -header_filter=\".*\\.\\(hpp\\|hxx\\|h\\)\"'
" let g:syntastic_cpp_clang_tidy_post_args = ""

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_check_on_w = 0

" nnoremap <leader>sc :SyntasticCheck<CR>
