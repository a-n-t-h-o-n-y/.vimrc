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
set wrap
set textwidth=80
set formatoptions+=t
set ruler
set so=7
set lazyredraw
set autoread
set softtabstop=4   " Space count for tab key in INSERT mode
set smarttab        " When off, <Tab> will not inserts spaces in front of a line
cd ~/Documents/C++/
set linebreak
set completeopt-=preview
set expandtab " Tabs converted to spaces for Indent plugin
set guicursor= " neovim update 4/2/17 removed $NVIM_TUI_ENABLE_CURSOR_SHAPE
set mouse=a

" Font 'Noto Mono for Powerline' size 14

" Install vim-plug with:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install plugins with :PlugInstall

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'rhysd/vim-clang-format'
Plug 'benekastah/neomake'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-obsession'
Plug 'airblade/vim-gitgutter'
Plug 'critiqjo/lldb.nvim'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'majutsushi/tagbar'
Plug 'raimondi/delimitmate'
Plug 'romainl/flattened'
Plug 'yonchu/accelerated-smooth-scroll'

" Plug 'scrooloose/syntastic'
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-surround'
" Plug 'tpope/vim-commentary'
call plug#end()

" Save shortcut
noremap <Leader>s :update<CR>

" Esc shortcut
:inoremap jk <Esc>

colorscheme flattened_light
set background=light

" Bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Buffer Management
nnoremap <Leader>b :ls<CR>:b<Space>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" Open/reload .vimrc
nnoremap <leader>ev :edit $MYVIMRC<CR>  
nnoremap <leader>v :source $MYVIMRC<CR>     

" Airline Config
" set statusline=%{fugitive#statusline()}
set statusline+=%#warningmsg#
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%t'
let g:airline_section_y = ''
let g:airline_section_x = '' 
let g:airline_powerline_fonts = 1

" Tagbar Config
nmap <silent> <leader>tb :TagbarToggle<CR>
let g:tagbar_autoclose = 0
let g:tagbar_compact = 1

" YouCompleteMe Config
let g:ycm_global_ycm_extra_conf =
    \ '~/.vim/plugged/youcompleteme/.ycm_extra_conf.py'
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_python_interpreter = '/usr/bin/python2'

" CtrlP Config
let g:ctrlp_dotfiles = 1

" NERDTree Config
nnoremap <leader>nt :NERDTreeToggle<Enter>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
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

" Easy Motion Config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

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
let g:neomake_cpp_clangtidy_args = ['-checks=*,-llvm-include-order', '-header-filter=.*',
            \ '-extra-arg=-std=c++14']

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

