" Plugins with vim-plug
call plug#begin('~/.local/share/nvim/plugged')

  " Ctrl-P
  Plug 'ctrlpvim/ctrlp.vim'

  " A filetype plugin for csv files
  Plug 'chrisbra/csv.vim'

  " Provides some utilities for managing terminal splits
  Plug 'vimlab/split-term.vim'

  " Provides the Apprentice and Lightening colour schemes
  Plug 'romainl/Apprentice'

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

  " vim-easy motion for easy movement
  Plug 'easymotion/vim-easymotion'

  " ack.vim for ack
  Plug 'mileszs/ack.vim'

  " tabular to align text across lines
  Plug 'godlygeek/tabular'

  " vim-vinegar to enhance netrw
  Plug 'tpope/vim-vinegar'

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

" Set apprentice as the colourscheme
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
"" Consistent console width
let R_setwidth = 2
"" Disable mapping of "_" to " -> "
let R_assign = 0
"" Disable matching of <
let R_rnowebchunk = 0
"" Don't clobber the tmux window title
let R_tmux_title = "automatic"
"" Use my own tmux config
let R_notmuxcong = 1
"" R-friendly abbreviations
iab >> |>
iab << <-
iab <expr> %>% '\|>'
"" Insert 'last updated' date into R Markdown header with lll
iab <expr> lll 'Last updated `r lubridate::today()`'
"" R Markdown skeleton
autocmd BufNewFile *.Rmd 0r ~/nvim/skeletons/skeleton.Rmd

" Allow mouse input
set mouse=a

" Set scrolling buffer
set scrolloff=4

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
" let g:python_host_prog = '/Users/wilkox/.pyenv/versions/neovim2/bin/python'
" let g:python3_host_prog = '/Users/wilkox/.pyenv/versions/neovim3/bin/python'

" Configure vim-argwrap
"" vim-argwrap
" Set invocation to <Leader>,
nnoremap <silent> <Leader>, :ArgWrap<CR>
" Wrap closing brace to newline
let g:argwrap_wrap_closing_brace = 1

"" vim-dispatch
" Prevent apostrophe/single quote key mapping from stomping on ' -> : mapping 
let g:nremap = {"'" : ""}

"" vim-easymotion
" Bind motions to <Leader>, instead of <Leader><Leader>
map <Leader> <Plug>(easymotion-prefix)
" Bind s in normal mode to bi-directional single character search
nmap s <Plug>(easymotion-s)

"" undo
set undofile
set undodir=~/nvim/undodir

"" Try to stop netrw buffers from hanging around indefinitely
"" from https://github.com/tpope/vim-vinegar/issues/13
set nohidden
augroup netrw_buf_hidden_fix
  autocmd!
  autocmd BufWinEnter *
        \  if &ft != 'netrw'
        \|     set bufhidden=hide
        \| endif
augroup end

" Enable true colour support
set termguicolors

" split-term
"" Add localleader mappings for new terminal splits
nnoremap <LocalLeader>t :Term<cr>
nnoremap <LocalLeader>vt :VTerm<cr>

" Render markdown to PDF without fuss
command! MakePDF :w !pandoc -f markdown -t pdf --pdf-engine=xelatex -o %:r.pdf
