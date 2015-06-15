
" =========== Vim tips ===================
" Complete previous = <C-P>
" Complete next = <C-N>
"
" Goto old cursor location = <C-O>
" Goto next cursor location = <C-I>
" Use <C-O><C-O> to reopen closed file where you have been
"
" Press % when the cursor is on a quote, paren, bracket, or brace to find its
" match, if the cursor is not over any of those it shifts to the right until
" it hits one of them.
"
" q<letter> - records a macro.
" and
" @<same-letter> - plays it back.
"
" To sort items in a file.
" :%!sort
" To sort items in line range 3-5
" :3,5!sort
"
" To comment select some line using CTRL+V then insert some char at the beginning of each
" column useing 'I' (to insert before the selection) and then '#'.
" also you can use 'A' (to append to selection)
"
" Use vim-bindings on the command line in bash: 'set -o vi' In other,
" readline-using programs, hit control-alt-j to switch from emacs to vim bindings.
"
" Search first and then vim will re-use your search. For example:
" /blue\(\d\+\)
" :%s//red\1/
" Is equivalent to:
" :%s/blue\(\d\+\)/red\1/
"
" Short and useful:
" sort selected rows                       :sort
" search for word under cursor             *
" format selected code                     =
" convert selected text to uppercase       U
" convert selected text to lowercase       u
" invert case of selected text             ~
" convert tabs to spaces                   :retab
" start recording a macro                  qX (X = key to assign macro to)
" stop recording a macro                   q
" playback macro                           @X (X = key macro was assigned to)
" replay previously played macro *         @@
" auto-complete a word you are typing **   CTRL + n
" bookmark current place in file           mX (X = key to assign bookmark to)
" jump to bookmark                         `X (X = key bookmark was assigned
"                                               ` = back tick/tilde key)
" show all bookmarks                       :marks
" close all other split screens            :only
"
" In normal mode you can use * and # to search for a word under the cursor.
" * searches forward for the word, while # searches backwards.



" ================ General ==================
" Vim, not vi. To use advanced features, put this at the start of .vimrc
set nocompatible

" When opening new file vim will look for special commands in it and run them
" We disable this ablity
set nomodeline

" Sets how many lines of history VIM has to remember (default is 20)
set history=300

" Number of undo levels
set undolevels=400

" Disable showmarks plugin
let showmarks_enable=0

" Start pathogen plugin
execute pathogen#infect()



" =============================== FUNCTIONS ========================
" Setup alias to use in colon mode (last-line mode)
function! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
                \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
                \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" My change to '| r ++edit # |' removed '++edit'
" Use :diffoff to switch this off again
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

"CleverTab - tab to autocomplete is we are on text OR to move indent
" Does not matter if this returns <c-n> or <c-p> since they both cycle through
" the list of suggestions (they just use different order/direction)
function CleverTab()
    if strpart( getline('.'), col('.')-2, 1) =~ '^\k$'
        return "\<C-n>"
    else
        return "\<Tab>"
    endif
endfunction


" =========================== EDITING =============================
" EDITING setting have to be before FILE settings because file setting may change
" values for tab expansion (if its a Makefile for example)

" Spaces are better than a tab character
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4

" Indentation
set autoindent
set cindent        " This replaces 'smartindent'

" Always round tab indent to nearest shiftwidth
" This applies to > and < shift commands
set shiftround

" show invisible characters
" but only show tabs as '>·' and trailing whitespace as '·'
set list
set listchars=tab:>-,trail:·

" This is the way I like my quotation marks and various braces
" What's cool is if you have :paste mode enabled, this expansions
" will NOT take place. So to insert just one bracket toggle paste mode.
inoremap ' ''<Left>
inoremap " ""<Left>
inoremap ( ()<Left>
" inoremap < <><Left>
inoremap { {}<Left>
inoremap [ []<Left>

" Add a bit extra margin to the left for folded code
" set foldcolumn=6

" Enable mouse support in console if possible
if has('mouse')
    set mouse=a
endif

" do lots of scanning on tab completion,
" consider adding '+= k' to scan in dictionary
set complete=.,w,b,u,U,t,i,d

" tilde is the toggle case operator
" Now '~' will be same as 'g~'
" set tildeop " example: ~aw (dog -> DOG)

" See :h formatoptions"
if v:version > 703 || v:version == 703 && has("patch541")
    set formatoptions+=j " Delete comment character when joining commented lines
endif



" =========== FILES =================
" Help when typing commands (after colon in last line mode)
set wildmenu
set wildmode=longest:full,full

" Ignore temporary object files when menu completion
set wildignore=*.o,*~,*.pyc,*/.DS_Store,*/.git/*,*/.svn/*,*/.hg/*

" Lookup ctags -tags- file up in the directory until one is found
set tags=tags;/

" New awesome stuff: Persistent Undo!
set undofile                " Save undo's after file closes
set undodir=~/.vim/undo/    " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Prevent backup files from cluttering up working directories
" By removing '.' directory from preference and adding .vim/ directory as first
set backupdir=~/.vim/backup,~/tmp,~/
set directory=~/.vim/swap,~/tmp,/var/tmp,/tmp

" Enable filetype plugins
filetype plugin on
filetype indent on

" set UTF-8 as standard encoding and en_US as standard language
set encoding=utf8

" Use unix as the standard file type (for line endings and so on)
" Will be tried in order (unix first)
set ffs=unix,mac,dos

" When editing a file, always jump to the last cursor position
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal g'\"" |
  \ endif
endif

" The idea of 'viminfo' is to save info from one editing session for the next
" by saving the data in an 'viminfo file'. So next time I start up Vim I can
" use the search patterns from the search history and the commands from the
" command line again. I can also load files again with a simple ':b bufname'.
" And Vim also remember where the cursor was in the files I edited. See ':help
" viminfo' for more info on Vim's 'viminfo'. :-}
set viminfo+=%
set viminfo+='50
set viminfo+=\"100
set viminfo+=:100
set viminfo+=s10
set viminfo+=h
set viminfo+=n~/.viminfo

" Configure tabs for various file types. No change tabs to spaces in Makefiles
autocmd FileType make setlocal tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab

"Ensure vim is not recursively invoked (man-db does this)
"when doing ctrl-[ on a man page reference
augroup man
    autocmd!
    autocmd FileType man let $MANPAGER=""
augroup END


" =============== MOVEMENT =========================
set scrolloff=7               " keep at least 5 lines above/below cursor
set sidescrolloff=7           " keep at least 5 lines left/right cursor

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" There are several commands which move the cursor within the line. When you
" get to the start/end of a line then these commands will fail as you cannot
" go on. However, many users expect the cursor to be moved onto the
" previous/next line. Vim allows you to chose which commands will -wrap- the
" cursor around the line borders. Here I allow the cursor left/right keys and
" dis-allow using 'h','l' keys. Then h,l can only move within the line.
set whichwrap=<,>

" Moving lines and blocks up and down in normal/insert/visual modes
" note: this maps to ALT + motion key
" see http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" To move between windows with CTRL + hjkl, instead of CTRL-W + hjkl
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" =================== INTERFACE ========================
" Show status line (info about which file you are on)
set laststatus=2

" Show where you are in the file, line and column and %
set ruler

" show line numbers "
set number

" Set the command window height to 2 lines, to avoid
" many cases of having to -press <Enter> to continue-
set cmdheight=2

" show letter/numbers in right corner (command mode)"
set showcmd

" Highlight search result
set hlsearch

" Search for string as you type it. Like in a browser (not sure if this is
" good idea)
set incsearch

" For regular expression (search and replace), turn on magic chars by default
set magic

" Highlight matching brace
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=1

" Speed up response to ESC key, default timeoutlen=1000
set notimeout
set ttimeout
set timeoutlen=300

" See :h completeopt"
" This is to do with text completion menu.
set completeopt=longest,menuone,preview

" Turn off error bells
set noerrorbells
set visualbell
set t_vb=


" ========================= COLORS AND FONTS ======================
" tell vim to expect 256 colors (some terminals may not support so many colors?)
set t_Co=256

" Set t_ut to disable Background Color Erase.
" Now vim should not try to use default terminal color for background
" See http://sunaku.github.io/vim-256color-bce.html
" Also see for more info related to background and colorschemes:
" http://vim.1045645.n5.nabble.com/Background-color-does-not-change-td1172332.html
set t_ut=

" Tell vim that we are using dark background
set background=dark

" change to custom color scheme
try
    colorscheme vividchalk
catch
endtry

" Enable syntax highting. Check out 'syntax enable' vs 'syntax on'
syntax enable

" When started in diff mode, I only want to see diff colours
if &diff
    syntax off
endif

" show location of cursor using a horizontal line.
set cursorline

" adjust color, 53 is perfect
" hi CursorLine term=none cterm=none ctermbg=53
hi CursorLine term=none cterm=none

" Set bg color to work woth vividchalk colorscheme
" otherwise terminal background remains dark purple and does not look nice
highlight Normal ctermfg=grey ctermbg=black


" ===================== ALIASES AND SHORTCUTS =======================
" This is your own personal modifier key, as 'g' is Vim’s modifier key "
" Default leader is '\'
let mapleader = ","

" Enter :sss to toggle and untoggle spell checking
" SetupCommandAlias('sss', 'setlocal spell!')

" Swap ; and :  Convenient. Also allow space to enter last-line mode.
nnoremap <Space> :
nnoremap ; :
nnoremap : ;

" This is totally awesome - remap jj to escape in insert mode.
" You'll never type jj anyway, so it's great!
" inoremap jk <Esc>
" inoremap kj <Esc>
" Actually a better idea: see http://vim.wikia.com/wiki/Map_caps_lock_to_escape_in_XWindows
" to sum it up: just use ALT/META + normal_key OR swap CAPSLOCK with ESC (you
" can swap them system wide which is freaking awesome!)

"This unsets the -last search pattern- register by hitting return
nnoremap <CR> :noh<CR><CR>

"Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Hit F1 to write file to disk. <c-o> (CTRL + o) in insert mode temporary switches to
" normal mode.
noremap  <F1> :w<CR>
inoremap <F1> <C-o>:w<CR>

" press F7 to add semi-colon to end of line and return cursor to original
" place.
nnoremap <F7> $a;<Esc>

" Create blank newlines and stay in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" After selecting something in visual mode and shifting, I still want that"
" selection intact  So don't exit visual mode after shifting.
vmap > >gv
vmap < <gv


" Allow CleverTab but only in insert mode
inoremap <Tab> <C-R>=CleverTab()<CR>

" copy filepath[:line[:col]] to clipboard
" note: register '+' is the system clipboard
nmap gyf :call setreg('+', expand('%:p'), 'v')<cr>
nmap gyl :call setreg('+', expand('%:p').':'.line('.'), 'v')<cr>
nmap gyc :call setreg('+', expand('%:p').':'.line('.').':'.col('.'), 'v')<cr>

"<C-e> and <C-y> scroll the viewport a single line. Make them faster.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>
vnoremap <C-e> 5<C-e>
vnoremap <C-y> 5<C-y>

"This is necessary to allow pasting from outside vim. It turns off auto stuff.
"You can tell you are in paste mode when the ruler is not visible
set pastetoggle=<F2>

" Load local settings if they exist.
if filereadable($HOME . "/.vimrc.local")
    source ~/.vimrc.local
endif
