scriptencoding utf-8
let encoding='utf-8'
set nocompatible
syntax enable " Turn on syntax highlighting
filetype on
set hidden
set ignorecase
set history=100
set updatetime=250
set sessionoptions="blank,buffers,sesdir,folds,help,tabpages,winsize"

set wrap
set number
set textwidth=80
set colorcolumn=80
set formatoptions+=t
set ruler
set scrolloff=6
set lazyredraw
set autoread
set linebreak
set completeopt-=preview
set guicursor= 
set mouse=a

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab " Tabs as spaces
set autoindent
set smartindent

set wildmenu
set wildmode=list:longest,full
set wildcharm=<Tab>

" Font 'Noto Mono for Powerline' size 14

" Install vim-plug with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install plugins with :PlugInstall

call plug#begin('~/.vim/plugged')
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'benekastah/neomake'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'raimondi/delimitmate'
Plug 'romainl/flattened'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'moll/vim-bbye'

" Plug 'scrooloose/syntastic'
" Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme flattened_light
set background=light

" Exit insert mode on nvim terminal
tnoremap jk <C-\><C-n>

" Tag search
nnoremap <Leader>t :tselect /
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
nnoremap g<c-]> <c-]>
vnoremap g<c-]> <c-]>

" Window Movement
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Save shortcut
nnoremap <Leader>s :update<CR>
nnoremap <Leader>fs :ClangFormat<CR>:update<CR>zz

" Esc shortcut
inoremap jk <Esc>

" Bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search and replace under selection
vnoremap <Leader>r :s/

" Search and replace entire buffer
nnoremap <Leader>r :%s/

" Buffer Management
nmap <Leader>d :ls<CR>:Bd 

" Open/reload .vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>  
nnoremap <leader>v :source $MYVIMRC<CR>     

" Location List
nnoremap <leader>ll :call LocationListToggle()<cr>
let g:locationlist_is_open = 0
function! LocationListToggle()
    if g:locationlist_is_open
        lclose
        let g:locationlist_is_open = 0
        execute g:locationlist_return_to_window . "wincmd w"
    else
        let g:locationlist_return_to_window = winnr()
        lopen
        let g:locationlist_is_open = 1
    endif
endfunction

" Quickfix
nnoremap <leader>qf :call QuickfixToggle()<cr>
let g:quickfix_is_open = 0
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

" Airline Config
" set statusline+=%#warningmsg#
let g:airline_theme='solarized'
let g:airline_section_c = '%t'
let g:airline_section_y = ''
let g:airline_section_x = '' 
let g:airline_powerline_fonts = 1

" YouCompleteMe Config
let g:ycm_global_ycm_extra_conf =
    \ '~/.vim/plugged/youcompleteme/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_python_interpreter = '/usr/bin/python3'

" CtrlP Config
let g:ctrlp_dotfiles = 1
nnoremap <Leader>b :CtrlPBuffer<CR>

" GitGutter Config
let g:gitgutter_realtime = 1

" Clang Format Config
let g:clang_format#code_style = 'Chromium'
let g:clang_format#style_options = { "Standard" : "C++11" }
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>zz
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>

" NERD Commenter Config
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left
" instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Neomake Config - Clang Tidy
nnoremap <Leader>nm :Neomake<CR>
let g:neomake_cpp_enabled_makers =  ['clangtidy']
let g:neomake_cpp_clangtidy_args = ['-checks=*,-llvm-include-order,
            \-google-runtime-references', '-extra-arg=-std=c++14',
            \'-header-filter=.*']

" Auto Commenting turned off
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
  " Use ag in CtrlP for listing files. Fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

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
