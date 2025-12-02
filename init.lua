-- Plugins with vim-plug
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.local/share/nvim/plugged')

  -- nvim-lspconfig, required for Air
  Plug('neovim/nvim-lspconfig')

  -- Fuzzy file finder
  Plug('ctrlpvim/ctrlp.vim')

  -- Terminal split utilities
  Plug('vimlab/split-term.vim')

  -- Apprentice colour scheme
  Plug('romainl/Apprentice', { branch = 'fancylines-and-neovim' })

  -- Seamless navigation between nvim and tmux panes
  Plug('christoomey/vim-tmux-navigator')

  -- Quick commenting
  Plug('tpope/vim-commentary')

  -- Wrap/unwrap function arguments
  Plug('FooSoft/vim-argwrap')

  -- Surroundings manipulation
  Plug('tpope/vim-surround')

  -- Asynchronous builds
  Plug('tpope/vim-dispatch')

  -- Git integration
  Plug('tpope/vim-fugitive')

  -- Fast cursor movement
  Plug('easymotion/vim-easymotion')

  -- Ack integration
  Plug('mileszs/ack.vim')

  -- Text alignment
  Plug('godlygeek/tabular')

  -- Enhanced netrw
  Plug('tpope/vim-vinegar')

vim.call('plug#end')

-- Leader keys
vim.g.mapleader = ','
vim.g.maplocalleader = '\\'

-- Appearance
vim.opt.termguicolors = true
vim.cmd.colorscheme('apprentice')
vim.opt.relativenumber = true
vim.opt.number = true

-- Editing behaviour
vim.opt.clipboard:prepend('unnamed')
vim.opt.mouse = 'a'
vim.opt.scrolloff = 4
vim.opt.foldlevel = 99
vim.opt.inccommand = 'split'
vim.opt.hidden = false  -- Help netrw buffers not linger

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = 'en_au'
vim.opt.spellfile = vim.fn.expand('~/.local/share/nvim/spell/spellfile.add')
vim.opt.spellcapcheck = ''

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/state/nvim/undo')

-- netrw
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

-- General key mappings
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', "'", ':')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<Leader>/', ':nohlsearch<CR><C-l>')
vim.keymap.set('n', 'zl', '1z=')

-- Terminal mappings
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', 'jj', '<C-\\><C-n>')

-- R.nvim mappings
vim.keymap.set('v', '<Space>', '<Plug>RDSendSelection')
vim.keymap.set('n', '<Space>', '<Plug>RDSendLine')
vim.g.R_setwidth = 2

-- vim-argwrap
vim.keymap.set('n', '<Leader>,', ':ArgWrap<CR>', { silent = true })
vim.g.argwrap_wrap_closing_brace = 1

-- vim-dispatch: prevent apostrophe mapping conflict
vim.g.nremap = { ["'"] = '' }

-- vim-easymotion
vim.keymap.set('', '<Leader>', '<Plug>(easymotion-prefix)', { remap = true })
vim.keymap.set('n', 's', '<Plug>(easymotion-s)', { remap = true })

-- split-term
vim.keymap.set('n', '<LocalLeader>t', ':Term<CR>')
vim.keymap.set('n', '<LocalLeader>vt', ':VTerm<CR>')

-- Custom R indentation function
local function r_indent()
  local lnum = vim.fn.prevnonblank(vim.v.lnum - 1)
  local line = vim.fn.getline(lnum)
  local curr_line = vim.fn.getline(vim.v.lnum)

  if vim.fn.match(curr_line, '^\\s*[)\\]}]\\s*$') >= 0 then
    return vim.fn.indent(lnum) - vim.bo.shiftwidth
  end

  if vim.fn.match(line, '.*(\\s*$\\|{\\s*$\\|\\[\\s*$') >= 0 then
    return vim.fn.indent(lnum) + vim.bo.shiftwidth
  end

  return -1
end

-- Make it globally accessible for indentexpr
_G.r_indent = r_indent

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('Terminal', { clear = true })
autocmd({ 'TermOpen', 'TermChanged' }, {
  group = 'Terminal',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

augroup('RMarkdownSkeleton', { clear = true })
autocmd('BufNewFile', {
  group = 'RMarkdownSkeleton',
  pattern = '*.Rmd',
  command = '0r $XDG_CONFIG_HOME/nvim/skeletons/skeleton.Rmd',
})

augroup('RFileSettings', { clear = true })
autocmd('FileType', {
  group = 'RFileSettings',
  pattern = { 'r', 'rmd' },
  callback = function()
    vim.opt_local.indentexpr = 'v:lua.r_indent()'
    vim.opt_local.formatexpr = ''
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append('rot')
  end,
})

augroup('NetrwBufferFix', { clear = true })
autocmd('BufWinEnter', {
  group = 'NetrwBufferFix',
  callback = function()
    if vim.bo.filetype ~= 'netrw' then
      vim.opt_local.bufhidden = 'hide'
    end
  end,
})

-- Air R formatter and language server. The air binary is installed from
-- homebrew (air). https://posit-dev.github.io/air/editor-neovim.html
local lsp = vim.lsp
lsp.config['air'] = {
    on_attach = function(_, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                lsp.buf.format()
            end,
        })
    end,
}
lsp.enable('air')
