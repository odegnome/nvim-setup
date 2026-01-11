-- Remove line numbers when opening terminal inside nvim
vim.api.nvim_create_autocmd('TermOpen', { pattern = "*", command = "set nonumber norelativenumber" })

-- Use treesitters folding for installed parsers else default to syntax
vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        if require("nvim-treesitter.parsers").has_parser() then
            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        else
            vim.opt.foldmethod = "syntax"
        end
    end,
})
