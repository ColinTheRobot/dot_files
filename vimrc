" Start profiler
profile start ~/output.log
" Turn off vi compatibility
set nocompatible

set clipboard=unnamed
filetype off

" Big remaps
let mapleader = ','
let bclose_multiple = 0
:imap jj <ESC>
:imap bbb require 'pry'; binding.pry
:imap sss RSpec.configure { \|config\| config.backtrace_exclusion_patterns << /gems/ }


" Remove open banner
let g:netrw_banner = 0
" open files in new tab
let g:netrw_browse_split = 3

" relative path  (src/foo.txt)
nnoremap <leader>a :let @*=expand("%")<CR>

" FZF
set rtp+=/usr/local/opt/fzf

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" VIM-RUBY
syntax enable
filetype plugin indent on

" VROOM
" let g:vroom_cucumber_path = '*.feature'
let g:vroom_konacha_command = 'bundle exec rake js:jasmine:server'
let g:vroom_konacha_spec_root = '/spec/javascripts'

" Tabularize mappings
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a| :Tabularize /|<CR>
  vmap <Leader>a| :Tabularize /|<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" map <Leader>rt :w<cr>:call RunCurrentTest('!ts bxr')<CR>


" Basic visual settings
set t_Co=256
" colorscheme Benokai
colorscheme morning
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

" Hybrid line number
" set number relativenumber
"
" augroup numbertoggle
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
"   autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
" augroup END
"
" Make backspace work
set backspace=2

" Copy to clipboard with quotestar register
" set clipboard=unnamed
" Handle ugly whitespace
set list listchars=tab:>-,trail:•,precedes:<,extends:>
runtime macros/matchit.vim
" Big remaps
let mapleader = ','
let bclose_multiple = 0
:imap jj <ESC>
:imap bbb require 'pry'; binding.pry
:imap rrr File.write("#{subject}.data", cover_response.rating_log)
" :imap ttt trace = TracePoint.new(:raise) { |tp| binding.pry if tp.raised_exception.class == NoMethodError } trace.enable { [...] }

:imap cab <C-R>=CoAuthorFunc()<CR>
function! CoAuthorFunc()
 let user_input = input('First and last name: ')
 let split_input = split(user_input)

  return "Co-authored-by: " . split_input[0] . " <" . tolower(split_input[0]) . "." . tolower(split_input[1]) . "@simplybusiness.com>"
endfunction

" First, enable status line always
set laststatus=2
if version >= 700
  au InsertEnter * hi StatusLine ctermfg=226 ctermbg=232
  au InsertLeave * hi StatusLine ctermbg=240 ctermfg=232
endif

" Make those debugger statements painfully obvious
au BufEnter *.rb syn match error "\<require 'pry'; binding.pry\>"
au BufEnter *.js syn match error contained "\<debugger\>"

