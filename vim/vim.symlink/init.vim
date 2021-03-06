set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/bundle/Vundle.vim
" call vundle#begin()

set rtp+=/usr/local/opt/fzf
" start plugged
call plug#begin('~/.vim/plugged')

" Mandatory
Plug 'VundleVim/Vundle.vim'

" Misc writing stuff
Plug 'Townk/vim-autoclose'
Plug 'kien/rainbow_parentheses.vim'
" Plug 'scrooloose/syntastic'
" Plug 'w0rp/ale'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-dispatch'
" Plug 'janko-m/vim-test'

Plug 'tpope/vim-commentary'

" Plug 'Shougo/neocomplete.vim'

" Git
Plug 'tpope/vim-fugitive'
" Plug 'airblade/vim-gitgutter'

" Languages support
Plug 'tpope/vim-rails'
Plug 'sheerun/vim-polyglot'
Plug 'rust-lang/rust.vim'

" Status bar
" Plug 'bling/vim-airline'

" Proper formatting
Plug 'editorconfig/editorconfig-vim'
" Plug 'PreserveNoEOL'
" Plug 'ngmy/vim-rubocop'

" Finding files or searching on them
Plug 'vim-scripts/The-NERD-tree'
Plug 'jlanzarotta/bufexplorer'
" Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'

" Color scheme (need to change at end of file too)
Plug 'tomasr/molokai'
" Plug 'flazz/vim-colorschemes'
" Plug 'vim-misc'
" Plug 'xolox/vim-colorscheme-switcher'
"Plug 'farseer90718/flattr.vim'

call plug#end()
"call vundle#end()
filetype plugin indent on

syntax on

"limit the syntax highlighting to first 250 lines, or long lines
"will make vim slow
set synmaxcol=150

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=500

"color theme for terminal vim
colors molokai

" -------------------------
" /GENERAL
" -------------------------

" -------------------------
" BACKUPS
" -------------------------
set nobackup                      " do not keep backups after close
set nowritebackup                 " do not keep a backup while working
set noswapfile                    " don't keep swp files either
set backupdir=$HOME/.vimbackup    " store backups under ~/.vimbackup
set backupcopy=yes                " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vimswap,~/tmp,. " keep swp files under ~/.vimswap
" -------------------------
" /BACKUPS
" -------------------------

" -------------------------
" STATUSLINE
" -------------------------
"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

" let g:syntastic_enable_signs   = 1
" let g:syntastic_auto_loc_list  = 1
" let g:syntastic_quiet_messages = {'level': 'warnings'}

set statusline=%f       "tail of the filename

"display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
"set statusline+=%{StatuslineCurrentHighlight()} "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
" -------------------------
" /STATUSLINE
" -------------------------

" -------------------------
" GRAPHICAL
" -------------------------
"Visual
set ruler                  " show the cursor position all the time


" Experiments for performance
" set nolazyredraw           " turn off lazy redraw
set lazyredraw           " try for performance
set re=1 " https://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting/16920294#16920294

augroup ft_rb
  au!
  au FileType ruby setlocal re=1 foldmethod=manual
augroup END

set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set winwidth=140

" set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling

"Visual Cues
set showmatch             " brackets/braces that is
set mat=5                 " duration to show matching brace (1/10 sec)
set laststatus=2          " always show the status line
set ignorecase            " ignore case when searching
set nohlsearch            " don't highlight searches
set visualbell            " shut the fuck up
set showcmd               " show incomplete cmds down the bottom
set showmode              " show current mode down the bottom
set incsearch             " find the next match as we type the search
set hlsearch              " hilight searches by default
set nowrap                " dont wrap lines
set linebreak             " wrap lines at convenient points
set autoread              " reload files (no local changes only)
" -------------------------
" /GRAPHICAL
" -------------------------

" -------------------------
" MAPPINGS
" -------------------------
" remap <LEADER> to ',' (instead of '\')
let mapleader = ","

nnoremap <leader>a <C-w><Left>
nnoremap <leader>d <C-w><Right>
nnoremap <leader>w <C-w><Up>
nnoremap <leader>s <C-w><Down>

map <D-H> <C-w><Right><C-W>H<CR>
map <D-V> <C-w><Down><C-W>K<CR>

map <D-C> :vsplit<CR>
map <D-R> :split<CR>
map <leader>v :vsplit<CR>
map <leader>h :split<CR>

imap <D-1> <Esc>:tabn 1<CR>i
imap <D-2> <Esc>:tabn 2<CR>i
imap <D-3> <Esc>:tabn 3<CR>i
imap <D-4> <Esc>:tabn 4<CR>i
imap <D-5> <Esc>:tabn 5<CR>i
imap <D-6> <Esc>:tabn 6<CR>i
imap <D-7> <Esc>:tabn 7<CR>i
imap <D-8> <Esc>:tabn 8<CR>i
imap <D-9> <Esc>:tabn 9<CR>i

map <D-1> :tabn 1<CR>
map <D-2> :tabn 2<CR>
map <D-3> :tabn 3<CR>
map <D-4> :tabn 4<CR>
map <D-5> :tabn 5<CR>
map <D-6> :tabn 6<CR>
map <D-7> :tabn 7<CR>
map <D-8> :tabn 8<CR>
map <D-9> :tabn 9<CR>

map <leader>q :q<CR>
imap <leader>q :q<CR>


" -------------------------
" MAPPINGS
" -------------------------

"indent settings
set shiftwidth=2
set ts=2
set bs=2
set shiftround
set softtabstop=2
set expandtab
set smarttab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

"display tabs and trailing spaces
set list
set listchars=tab:▷⋅,trail:⋅,nbsp:⋅

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin indent on

set ofu=syntaxcomplete#Complete
let g:acp_behaviorKeywordLength = 4

"some stuff to get the mouse going in term
set mouse=a
" set ttymouse=xterm2

"tell the term has 256 colors
set t_Co=256

"hide buffers when not displayed
set hidden

"ctags
set tags=ctags

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
    let g:CSApprox_loaded = 1
endif

"clear the highlight as well as redraw
nnoremap <leader>/ :nohls<CR><C-L>

"make <D-intro> jump add new line as in Textmate
inoremap <D-CR> <ESC>o

"map to NERDtree
nnoremap <c-t> :NERDTreeToggle<CR>

"map to bufexplorer
nnoremap <leader>b :BufExplorer<cr>

"map to fuzzy finder text mate stylez
" let wildignore+=gems/**,coverage,tmp,*/.git/*,*/.hg/*,*/.svn/*,.DS_Store,test/fixtures/vcr_cassettes/**
" nnoremap <leader>r :ClearCtrlPCache<CR>:CtrlP<cr>
" nnoremap <leader>f :CtrlP<cr>
" nnoremap <leader>r :ClearCtrlPCache<CR>:CtrlP<cr>
nnoremap <leader>f :Files<cr>

let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

set wildignore+=gems/**,coverage,tmp,*/.git/*,*/.hg/*,*/.svn/*,.DS_Store,test/fixtures/vcr_cassettes/,test/fixtures/private,private

"comment lines as with textmate
" map <leader>g :TComment<cr>
" imap <leader>g :TComment<cr>
" vmap <leader>g :TComment<cr>
map <leader>g gcc

"prevent Autoclose from being annoying
nmap <unique> <Leader>c <Plug>ToggleAutoCloseMappings

"go back to last file
map <leader><leader> <C-^>

"make Y consistent with C and D
nnoremap Y y$

" -------------------
" KEYBINDS
" -------------------
"Move lines up and down
map <C-J> :m +1 <CR>
map <C-K> :m -2 <CR>

" move faster around up and down
nnoremap <space> :+15<cr>
nnoremap <s-space> :-15<cr>

"Duplicate a selection
vmap D y'>p

"one-key indentation
nmap > >>
nmap < <<

vnoremap < <gv
vnoremap > >gv

"Easier beginning/end of line
map H ^
map L $

" -------------------
" /KEYBINDS
" -------------------

"No Help, please
nmap <F1> <Esc>

"Numbers
set number
set numberwidth=5

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

" -------------------
" AUTO & OTHERS
" -------------------

" Project Tree
" autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))

" Disable netrw's autocmd, since we're ALWAYS using NERDTree
runtime plugin/netRwPlugin.vim
augroup FileExplorer
  au!
augroup END

let g:NERDTreeHijackNetrw = 0

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  if isdirectory(a:directory)
    call ChangeDirectory(a:directory)
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(stay)
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      NERDTree
      if !a:stay
        wincmd p
      end
    endif
  endif
endfunction

autocmd BufWritePre * :%s/\s\+$//e

au BufWritePost .vimrc so ~/.vimrc

" New filetypes
autocmd BufNewFile,BufRead *.thor setf ruby

" Mark as red every character after 80
" :au BufWinEnter * let w:m1=matchadd('Search', '\\%<81v.\\%>77v', -1)
" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\\%>80v.\\+', -1)

" Local config
" if filereadable("~/.vimrclocal")
"   source ~/.vimrclocal
" endif

" show git diff in the editor on `git commit`
autocmd FileType gitcommit DiffGitCached | wincmd p | wincmd H

let g:neocomplete#enable_at_startup = 1
