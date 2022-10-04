set modifiable

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Linter
" Plugin 'dense-analysis/ale'

" Fuzzyfind
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" Text aligner
Plugin 'godlygeek/tabular'

"Dispatch
Plugin 'tpope/vim-dispatch'

" Commenter
Plugin 'tomtom/tcomment_vim'

" Gutter notifications
Plugin 'airblade/vim-gitgutter'

" QuickFix nonsense
Plugin 'romainl/vim-qf'

" RoR
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'

" Go
" Plugin 'fatih/vim-go'


"vimcompletes me
Plugin 'ackyshake/VimCompletesMe'

" Rspec Runner
Plugin 'thoughtbot/vim-rspec'

call vundle#end()            " required
filetype plugin indent on    " required

" vim splits
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Copy to clipboard with quotestar register
set clipboard=unnamed
filetype off

" open files in new tab
let g:netrw_browse_split = 3
" hide dot files. show using `gh`
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
"
" Turn on the Wild menu
set wildmenu

" When searching try to be smart about cases
set smartcase

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Fast saving
nmap <leader>w :w!<cr>

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" Add a bit extra margin to the left
set foldcolumn=1

" FZF
set rtp+=/usr/local/opt/fzf

"SilverSearcher
let g:ackprg = 'ag --vimgrep'
" ctrl g for silver searcher with fzf
nnoremap <C-g> :Ag<Cr>


" VIM-RUBY
" syntax enable
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

set nobackup
set nowb
set noswapfile

set colorcolumn=80
set number
set tabstop=2
set shiftwidth=2
set smartindent
set autoindent
set expandtab

set hlsearch " highlight all search patterns

" Bars
highlight clear SignColumn
highlight VertSplit    ctermbg=236
highlight ColorColumn  ctermbg=237
highlight LineNr       ctermbg=236 ctermfg=200
highlight StatusLineNC ctermbg=238 ctermfg=0
highlight StatusLine   ctermbg=240 ctermfg=232
highlight Visual       ctermbg=240   ctermfg=0
highlight Pmenu        ctermbg=240 ctermfg=12
highlight PmenuSel     ctermbg=3   ctermfg=1
highlight SpellBad     ctermbg=0   ctermfg=1

highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10

" Make backspace work
set backspace=2

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" Don't lose file history when closing buffer
set undofile
set undodir=~/.vim/undodir

" Handle ugly whitespace
set list listchars=tab:>-,trail:•,precedes:<,extends:>
runtime macros/matchit.vim

" Big remaps
let mapleader = ','
let bclose_multiple = 0
:imap jj <ESC>

" Text macros
:imap bbb require 'pry'; binding.pry
" :imap ttt trace = TracePoint.new(:raise) { |tp| binding.pry if tp.raised_exception.class == NoMethodError } trace.enable { [...] }

" ,rt to run spec file
:nnoremap <leader>rt :execute "Dispatch rspec %"<cr>
" ,rs to run spec line
:nnoremap <leader>rs :execute "Dispatch rspec %:" . line(".")<cr>

" quickfix list
set switchbuf=newtab,usetab
autocmd! BufWinEnter *Quickfix* setlocal nowinfixheight

" First, enable status line always
set laststatus=2
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=226 ctermbg=232
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=232
endif
