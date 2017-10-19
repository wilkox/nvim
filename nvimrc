" Plugins with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'romainl/Apprentice' " Provides the Apprentice colour scheme
Plug 'christoomey/vim-tmux-navigator' " Move between nvim and tmux panes
call plug#end()

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
