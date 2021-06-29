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
set formatoptions+=t
set number relativenumber
set ruler
set scrolloff=2
set lazyredraw
set autoread
set linebreak
set completeopt-=preview
set guicursor= 
set mouse=a
set noic
" set cursorline
" set cursorcolumn

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
" curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install plugins with :PlugInstall

call plug#begin('~/.vim/plugged')
Plug 'valloric/youcompleteme'
Plug 'ctrlpvim/ctrlp.vim'
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
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'iamcco/markdown-preview.vim'
Plug 'jceb/vim-orgmode'
Plug 'dense-analysis/ale'
Plug 'neovimhaskell/haskell-vim'
" Plug 'benekastah/neomake'
call plug#end()

" Vertical Split Thin Line
autocmd! ColorScheme * hi VertSplit cterm=NONE ctermbg=NONE ctermfg=247
autocmd! ColorScheme * hi VertSplit gui=NONE   guibg=NONE   guifg=247

" Terminal Colors
set termguicolors
set background=light
colorscheme snow
let g:seoul256_background = 233

nnoremap <Leader>d :color seoul-dark<CR> :set background=dark<CR>
nnoremap <Leader>f :color snow<CR> :set background=light<CR>

" Exit insert mode on nvim terminal
tnoremap jk <C-\><C-n>

" Build
nnoremap <F9> :make<CR>
set makeprg=clang++\ -g\ -std=c++17\ %\ &&\ ./a.out
" set makeprg=make\ -j4\ -C\ build/\ $*

" Insert Date
nnoremap <F5> "=strftime("%b %d, %Y")<CR>P

" Tagbar
nmap <Leader>tb :TagbarToggle<CR>

" Gutentags
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnsSpZ',
      \ '--fields-C++=+{captures}',
      \ '--fields-C++=+{properties}',
      \ '--fields-C++=+{template}',
      \ ]
let g:gutentags_ctags_exclude = [
      \ '*.git', 'tags*',
      \ 'external', '*/tests/*',
      \ 'build', 'out.*',
      \ 'callgrind*', '.clang.d',
      \ 'bin', 'example', 'vendor', 'docs',
      \ '*.tmp', '*.cache',
      \ '*-lock.json', '*.lock', '*.json', 'node_modules',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx', '*.txt', '*.md',
      \ ]


" Window Movement
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Esc shortcut
inoremap jk <Esc>

" Bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Search and replace under selection
vnoremap <Leader>r :s/

" Search and replace entire buffer
nnoremap <Leader>r :%s/

" Open/Reload .vimrc
nnoremap <Leader>ev :edit $MYVIMRC<CR>
nnoremap <Leader>v :source $MYVIMRC<CR>

" Invisible Characters
set list
let &listchars = "tab:\u2192 ,extends:>,precedes:<,trail:\u00b7" " ,eol:\u00ac
let &showbreak = '>'

" YouCompleteMe Config
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

" Clang-Format
function FormatFile()
  let l:lines="all"
  if has('python3')
    py3f /usr/share/clang/clang-format.py
  elseif has('python')
    pyf /usr/share/clang/clang-format.py
  endif
endfunction

function FormatSelection()
  if has('python3')
    py3f /usr/share/clang/clang-format.py
  elseif has('python')
    pyf /usr/share/clang/clang-format.py
  endif
endfunction

" Save shortcut
nnoremap <Leader>s :update<CR>

" clang-format and save on cpp/hpp files
autocmd FileType cpp nnoremap <buffer> <Leader>s :call FormatFile() <bar> update<CR>

" clang-format selection
autocmd FileType cpp vnoremap <buffer> <Leader>cf :call FormatSelection()<CR>

" Enhanced Highlighting
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1

" Goyo/Limelight Config
nnoremap <Leader>g :Goyo<CR>
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

" vim-orgmode
let g:org_indent = 1

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ external
  " Use ag in CtrlP for listing files. Remove -a to respect .gitignore
  let g:ctrlp_user_command = 'ag %s -l -nocolor -g ""'
  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Auto Commenting turned off
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

autocmd FileType text setlocal foldmethod=indent

" ALE linters
let g:ale_linters={ 'c': ['clangtidy', 'cppcheck', 'gcc'], }
let g:ale_c_parse_compile_commands=1
let g:ale_cpp_clangtidy_checks =
            \ ['bugprone-*', 'cert-*', 'cppcoreguidelines-*',
            \ 'clang-analyzer-*', 'hicpp-*', 'misc-*', 'modernize-*',
            \ 'performance-*', 'portability-*', 'readability-*',
            \ '-readability-braces-around-statements',
            \ '-hicpp-braces-around-statements',
            \ '-readability-uppercase-literal-suffix',
            \ '-hicpp-uppercase-literal-suffix',
            \ '-cppcoreguidelines-non-private-member-variables-in-classes',
            \ '-misc-non-private-member-variables-in-classes',
            \ '-readability-redundant-access-specifiers',
            \]
let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_gcc_options = '-std=c++17 -Wall'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 0
let g:ale_lint_on_text_changed = 0
nnoremap <Leader>ct :ALELint<CR>
