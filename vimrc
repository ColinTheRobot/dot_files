" Turn off vi compatibility
set nocompatible

" LSP
set runtimepath+=~/.vim-plugins/LanguageClient-neovim
set hidden

" Don't send a stop signal to the server when exiting vim.
" This is optional, but I don't like having to restart Solargraph
" every time I restart vim.
"
  
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 0
let g:LanguageClient_serverCommands = {
       \  'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
      \}
set completefunc=LanguageClient#complete
set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
nnoremap <silent> ft :call LanguageClient#textDocument_formatting()<CR>

" let g:ycm_language_server += [
"   \   {
"   \     'name': 'ruby',
"   \     'cmdline': [ expand( g:ycm_lsp_dir . '~/.rbenv/shims/solargraph' ), 'stdio' ],
"   \     'filetypes': [ 'ruby' ],
"   \   },
"   \ ]

" Configure ruby omni-completion to use the language client:
" autocmd FileType ruby setlocal omnifunc=LanguageClient#complete

set clipboard=unnamed
filetype off

" Big remaps
let mapleader = ','
let bclose_multiple = 0
:imap jj <ESC>
:imap bbb require 'pry'; binding.pry
:imap sss RSpec.configure { \|config\| config.backtrace_exclusion_patterns << /gems/ }

" open files in new tab
let g:netrw_browse_split = 3
" hide dot files. show using `gh`
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" relative path  (src/foo.txt)
" nnoremap <leader>a :let @*=expand("%")<CR>

" FZF
set rtp+=/usr/local/opt/fzf

" VIM-RUBY
" syntax enable
syntax on             " Enable syntax highlighting
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" Tabularize mappings
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a| :Tabularize /|<CR>
  vmap <Leader>a| :Tabularize /|<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

" vim-rspec
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader><S-r> :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

let g:rspec_command = "!spring rspec {spec}"

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

