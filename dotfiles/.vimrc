if 0 | endif

if &compatible
  set nocompatible
endif

if has('vim_starting')
    set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand($HOME.'/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'elixir-lang/vim-elixir'
NeoBundle 'ervandew/supertab'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'pbrisbin/vim-mkdir'
NeoBundle 'rking/ag.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'vim-ruby/vim-ruby'

if filereadable($HOME . "/.vimrc.bundles.local")
  source ~/.vimrc.bundles.local
endif

call neobundle#end()

filetype  plugin on
filetype  indent on
syntax on

NeoBundleCheck

colorscheme default

set autoindent                         " Copy indent from current line
set autoread                           " Read open files again when changed outside Vim
set autowrite                          " Write a modified buffer on each :next , ...
set backspace=indent,eol,start         " Backspacing over everything in insert mode
set history=200                        " Keep 200 lines of command line history
set hlsearch                           " Highlight the last used search pattern
set incsearch                          " Do incremental searching
set list
set listchars=tab:»·,trail:·,nbsp:·
set nobackup                           " Don't constantly write backup files
set noswapfile                         " Ain't nobody got time for swap files
set noerrorbells                       " Don't beep
set nowrap                             " Do not wrap lines
set nowritebackup
set noshowmode
set number                             " Show line numbers
set numberwidth=5                      " Make line number gutter at least 5 chars wide
set popt=left:8pc,right:3pc            " Print options
set ruler                              " show the cursor position all the time
set shiftwidth=2                       " Number of spaces to use for each step of indent
set showcmd                            " Display incomplete commands in the bottom line of the screen
set ignorecase                         " Ignore case when searching....
set smartcase                          " ...unless uppercase letter are used
set tabstop=2                          " Number of spaces that a <Tab> counts for
set expandtab                          " Make vim use spaces and not tabs
set undolevels=1000                    " Never can be too careful when it comes to undoing
set hidden                             " Don't unload the buffer when we switch between them. Saves undo history
set visualbell                         " Visual bell instead of beeping
set wildignore=*.swp,*.bak,*.pyc,*.class,tmp/**,dist/**,node_modules/**  " wildmenu: ignore these extensions
set wildmenu                           " Command-line completion in an enhanced mode
set wildmode=list:longest,list:full
set shell=bash                         " Required to let zsh know how to run things on command line
set ttimeoutlen=50                     " Fix delay when escaping from insert with Esc
set clipboard=unnamed
set scrolloff=3                        " Start scrolling the window 3 rows before the end
set sidescrolloff=3                    " Start scrolling the window 3 columns before the end
set showbreak=↪\
set textwidth=80                       " Set default textwidth to 80
set colorcolumn=+1                     " Mark the 81st column
set laststatus=2                       " Make the second to last line of vim our status line
set splitbelow                         " Vertical splits open under the current
set splitright                         " Horizontal splits open next to the current
set modeline                           " Respect modelines
set modelines=4
set diffopt+=vertical
set title                              " Show the PWD and current file in terminal title


if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

  au BufNewFile,BufRead *.json set ft=javascript

  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  autocmd FileType gitcommit setlocal textwidth=72

  autocmd FileType css,scss,sass setlocal iskeyword+=-
endif

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Leader
let mapleader=","

" Setup Airline
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''                           " No separator as they seem to look funky
let g:airline_right_sep=''                          " No separator as they seem to look funky
let g:airline#extensions#syntastic#enabled = 1      " Do show syntastic warnings in the status line
let g:airline#extensions#tabline#show_buffers = 0   " Do not list buffers in the status line
let g:airline_section_x = ''                        " Do not list the filetype or virtualenv in the status line
let g:airline_section_y = '[L%04l,C%04v]'  " Replace file encoding and file format info with file position
let g:airline_section_z = ''                        " Do not show the default file position info

" Setup syntastic
let g:syntastic_check_on_open=1                   " check for errors when file is loaded
let g:syntastic_javascript_checkers = ['eslint', 'jshint']  " sets eslint or jshint as our javascript linter
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_mode_map={ 'mode': 'active',
                     \ 'active_filetypes': [],
                     \ 'passive_filetypes': ['html', 'handlebars'] }

" Setup automatic detection of ESLint, JSHint and JSCS in a project
function! HasConfig(file, dir)
  return findfile(a:file, escape(a:dir, ' ') . ';') !=# ''
endfunction

function! FindConfig(prefix, what, where)
  let cfg = findfile(a:what, escape(a:where, ' ') . ';')
  return cfg !=# '' ? ' ' . a:prefix . ' ' . shellescape(cfg) : ''
endfunction

autocmd FileType javascript let b:syntastic_checkers =
    \ HasConfig('.eslintrc', expand('<amatch>:h')) ? ['eslint'] :
    \ HasConfig('.jshintrc', expand('<amatch>:h')) ? ['jshint'] :
    \ HasConfig('.jscsrc', expand('<amatch>:h')) ? ['jshint'] :
    \ ['standard']

autocmd FileType javascript let b:syntastic_javascript_jscs_args =
    \ get(g:, 'syntastic_javascript_jscs_args', '') .
    \ FindConfig('-c', '.jscsrc', expand('<afile>:p:h', 1))

" Setup ctrlp
let g:ctrlp_custom_ignore = '\v[\/](transpiled)|dist|tmp|node_modules|(\.(swp|git|bak|pyc|DS_Store))$'

" Setup nerdtree
map <Leader>d :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeShowHidden=1
let g:NERDTreeMinimalUI=1

" Local config
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
