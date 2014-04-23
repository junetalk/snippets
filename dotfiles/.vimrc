"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible		"不要vim模仿vi模式，建议设置，否则会有很多不兼容的问题
set history=2000	    " Sets how many lines of history VIM has to remember
filetype plugin on 		" load filetype plugins settings
filetype indent on 		" load filetype indent settings

command W w !sudo tee % > /dev/null

set autoread        	" Set to auto read when a file is changed from the outside

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu 	    	" Turn on the WiLd menu
set wildignore=*/tmp/*,*.so,*.swp,*.zip,*.class	" Ignore compiled files
set title           	" show title in console title bar
set ttyfast         	" smoother changes
set cmdheight=2     	" Height of the command bar
set lazyredraw 	    	" do not redraw while running macros
set linespace=0     	" don't insert any extra pixel lines betweens rows
set matchtime=5         " how many tenths of a second to blink matching brackets for
set hlsearch        	" Highlight search results
set incsearch       	" Makes search act like search in modern browsers
set nohlsearch 		    " do not highlight searched for phrases
set nostartofline   	" leave my cursor where it was
set novisualbell    	" don't blink
set number 	    	    " turn on line numbers
set numberwidth=5   	" We are good up to 99999 lines
set report=0 		    " tell us when anything is changed via :...
set ruler 	            " Always show current positions along the bottom
set scrolloff=10 	    " Keep 10 lines (top/bottom) for scope
set shortmess=aOstT 	" shortens messages to avoid 'press a key' prompt
set showcmd 		    " show the command being typed
set showmatch 		    " show matching brackets
set magic           	" For regular expressions turn magic on
set mat=2           	" How many tenths of a second to blink when matching brackets


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable		    " Enable syntax highlighting
set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

let &termencoding=&encoding 
set fileencodings=utf-8,gbk 
set encoding=utf8	    " Set utf8 as standard encoding and en_US as the standard language
set ffs=unix,dos,mac	" Use Unix as the standard file type

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab		    " Use spaces instead of tabs
set smarttab		    " Be smart when using tabs ;)
set shiftwidth=4	    " 1 tab == 4 spaces
set tabstop=4

set lbr					" Linebreak on 500 characters
set tw=500

set ai                  "Auto indent
set si                  "Smart indent
set wrap                "Wrap lines

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
set laststatus=2		" Always show the status line

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()

let g:nerdtree_tabs_open_on_console_startup=1       "设置打开vim的时候默认打开目录树
map <leader>n <plug>NERDTreeTabsToggle <CR>         "设置打开目录树的快捷键


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
