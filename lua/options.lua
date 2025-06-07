-- Copied from https://martinlwx.github.io/en/config-neovim-from-scratch/

-- Don't know what this is..
vim.opt.completeopt = {'menu','menuone','preview','noselect'}
vim.opt.mouse = '' -- disable mouse in nvim; default is nvi, i.e normal, visual, insert
-- [[
-- Turning paste mode on has a side effect that autopairs plugin stops working
-- ]]
-- vim.opt.paste = true -- when pasting, does not autoindent

-- vim.opt.termguicolors = true

-- Text formatting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- vim.opt.autoindent = true
-- vim.opt.smartindent = true

-- UI config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Does not show -- INSERT --; might regret this!
vim.opt.showmode = false

-- Searching
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Swap file
vim.opt.swapfile = false
vim.opt.backup = false

-- Fold method
-- =syntax works for rust, but indent with py
-- vim.opt.foldmethod = 'indent'
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.diagnostic.config({ virtual_text = true })
