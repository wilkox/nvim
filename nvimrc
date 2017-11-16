" Plugins with vim-plug
call plug#begin('~/.vim/plugged')

  " Provides the Apprentice colour scheme
  Plug 'romainl/Apprentice'

  " Move between nvim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'

  " vim-pandoc
  Plug 'vim-pandoc/vim-pandoc', {'for': 'markdown'}
  Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'markdown'}

  " vim-easymotion
  Plug 'easymotion/vim-easymotion'

  " Nvim-R
  Plug 'jalvesaq/Nvim-R'

" End plugin block
call plug#end()

" Leader
"" Map Leader to comma
let mapleader=","
"" Map localleader to backslash
let maplocalleader = "\\"

" vim-pandoc settings
"" Smart auto-formatting with hard wraps
let g:pandoc#formatting#mode='hA'

" Show relative line numbers
set relativenumber
set number

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

" Live substitution
set inccommand=split

" Custom keybindings
"" jj in insert mode -> ESC
inoremap jj <ESC>
"" ' in normal mode to :
nnoremap ' :

" Prevent the frustration of entering Ex mode by accidentally typing Q
nnoremap Q <nop>

" Map <Leader>/ (\/) to clearing search highlight
nmap <Leader>/ :nohlsearch<CR><C-l>

" Spell checking
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

" Remnants of vim-notes for study in stage 2 - remove after 2017
"" link_slides
nnoremap <Leader>os :call link_slides#open_slides()<cr>
"" Uni study
" Function to generate Anki flashcards from notes
function! MakeAnkiFlashCards ()
  ! anki_from_notes.pl "%:p"
endfunction
nnoremap <Leader>fc :call MakeAnkiFlashCards()<cr>

" Nvim-R settings
"" Press the space bar to send lines (in Normal mode) and selections to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine
"" Vertical split for R pane
let R_tmux_split = 1
let R_min_editor_width = 70
"" Disable mapping of "_" to " -> "
let R_assign = 0
"" Disable matching of <
let R_rnowebchunk = 0
"" Don't clobber the tmux window title
let R_tmux_title = "automatic"
"" Don't show R documentation in vim
let R_nvimpager = "no"
"" Use my own tmux config
let R_notmuxcong = 1
"" R-friendly abbreviations
iab >> %>%
iab << <-

" Mouse
set mouse=a

" In terminal mode, remap Esc so it actually escapes
tnoremap <Esc> <C-\><C-n>
tnoremap jj <C-\><C-n>

" netrw configuration
"" Tree view by default
let g:netrw_liststyle = 3
"" Hide the banner
let g:netrw_banner = 0
