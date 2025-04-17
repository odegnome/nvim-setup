local opts = {
    noremap = true,
    silent = true,
}

vim.g.mapleader = ','

-----------------
-- Normal mode --
-----------------

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Back to netrw
vim.keymap.set('n', '<leader>rw', vim.cmd.Ex)

-- Scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')


-- colorschemes
-- '<cmd>hi DiagnosticError ctermfg=lightblue<cr>' sets the error message highlighting to light blue
-- because the default is red which is not visible on slate colorscheme.
vim.keymap.set('n', '<leader>s', '<cmd>colorscheme slate<cr><cmd>hi DiagnosticError ctermfg=lightblue<cr>')
-- vim.keymap.set('n', '<leader>d', '<cmd>colorscheme peachpuff<cr>')
