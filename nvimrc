" Plugins with vim-plug
call plug#begin('~/.nvim/plugged')

  " Provides the Apprentice colour scheme
  Plug 'romainl/Apprentice'

  " Move between nvim and tmux panes
  Plug 'christoomey/vim-tmux-navigator'

  " vim-easymotion
  Plug 'easymotion/vim-easymotion'

  " Nvim-R
  Plug 'jalvesaq/Nvim-R'

  " deoplete autocompletion
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " vim-commentry
  Plug 'tpope/vim-commentary'

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
let R_tmux_split = 1
let R_min_editor_width = 70
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
