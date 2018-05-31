" Plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')

  " Provides the Apprentice and Lightening colour schemes
  Plug 'romainl/Apprentice'
  Plug 'wimstefan/Lightning'

  " Move between nvim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'

  " Nvim-R for R integration
  Plug 'jalvesaq/Nvim-R'

  " deoplete autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " vim-commentry for quickly commenting out lines
  Plug 'tpope/vim-commentary'

  " vim-argwrap for wrapping function arguments neatly
  Plug 'FooSoft/vim-argwrap'

  " vim-surround for adding, changing and removing surroundings
  Plug 'tpope/vim-surround'

  " vim-dispatch for asynchronous builds
  Plug 'tpope/vim-dispatch'

  " vim-fugitive for git
  Plug 'tpope/vim-fugitive'

  " vim-notes for uni notes
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-notes'

" End plugin block
call plug#end()

" Allow filetype plugins
filetype plugin on

" Define the leader and localleader
"" Map Leader to comma
let mapleader=","
"" Map localleader to backslash
let maplocalleader = "\\"

" Configure deoplete autocompletion plugin
let g:deoplete#enable_at_startup = 1
"" Use TAB to complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Show relative line numbers, except in terminal panes
set relativenumber
set number
au TermOpen * setlocal nonumber norelativenumber
au TermChanged * setlocal nonumber norelativenumber

" When a file is opened, open all folds by default
set foldlevel=99

" Use spaces instead of hard tabs
set expandtab

" Set soft tab to 2 spaces
set softtabstop=2 tabstop=2
set shiftwidth=2 

" Set Apprentice as the colourscheme
colorscheme apprentice

" Synchronise the unnamed register with the system clipboard
set clipboard^=unnamed

" When writing a substitution expression, preview the result in a split
set inccommand=split

" Custom keybindings
"" jj in insert mode -> ESC
inoremap jj <ESC>
"" ' in normal mode to :
nnoremap ' :

" Don't enter Ex mode when Q is accidentally typed
nnoremap Q <nop>

" Map <Leader>/ (\/) to clearing search highlight
nmap <Leader>/ :nohlsearch<CR><C-l>

" Configure spell checking
"" Turn spell checking on
set spell 
"" Set language to Australian English
set spelllang=en_au
"" Define spell file
set spellfile=$HOME/nvim/spellfile.add
"" Don't highlight capitalisation
set spellcapcheck=
"" Remap zl to correct to first option
nnoremap zl 1z=

" Configure nvim-R plugin
"" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
"" Open R in a vertical split
" let R_in_buffer = 0
" let R_applescript = 0
" let R_tmux_split = 1
" let R_min_editor_width = 70
"" Disable mapping of "_" to " -> "
let R_assign = 0
"" Disable matching of <
let R_rnowebchunk = 0
"" Don't clobber the tmux window title
let R_tmux_title = "automatic"
"" Use my own tmux config
let R_notmuxcong = 1
"" R-friendly abbreviations
iab >> %>%
iab << <-

" Allow mouse input
set mouse=a

" In terminal mode, remap Esc so it actually escapes
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" Configure netrw
"" Tree view by default
let g:netrw_liststyle = 3
"" Hide the banner
let g:netrw_banner = 0

" Use soft tabs with a width of two spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Configure pythons
"" https://github.com/tweekmonster/nvim-python-doctor/wiki/Advanced:-Using-pyenv
let g:python_host_prog = '/Users/wilkox/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/wilkox/.pyenv/versions/neovim3/bin/python'

" Configure vim-argwrap
"" vim-argwrap
" Set invocation to <Leader>,
nnoremap <silent> <Leader>, :ArgWrap<CR>
" Wrap closing brace to newline
let g:argwrap_wrap_closing_brace = 1

"" Uni notes
" Function to generate Anki flashcards from notes
function! MakeAnkiFlashCards ()
  ! anki_from_notes.pl "%:p"
endfunction
nnoremap <Leader>fc :call MakeAnkiFlashCards()<cr>
" Insert timestamp
iab <expr> dts strftime("%F")

"" vim-notes
" Set notes directory
let g:notes_directories = ['~/stage_3_notes']
" Disable indenting on tab keypress, as it overrides omnicompletion
let g:notes_tab_indents = 0
" Respect word boundaries
let g:notes_word_boundaries = 1
" Overwrite replacement of dashed lists with Unicode bullets
" There is an option for this but it doesn't work
" TODO submit this as a pull request at some point
function! xolox#notes#get_bullet(chr)
  return '-'
endfunction
" Highlight TODOs more obviously
highlight link notesTodo DiffText
" TODO italics
highlight notesItalic ctermfg=black ctermbg=darkcyan
" Don't highlight quoted text
highlight link notesSingleQuoted normal
highlight link notesDoubleQuoted normal
" Soft wraps in notes
autocmd FileType notes set wrap linebreak nolist textwidth=0 wrapmargin=0
" No new note template
let g:notes_shadowdir = "/tmp"
" Don't recognise asterisks as bullets
let g:notes_list_bullets = ['-']
