-- Remove line numbers when opening terminal inside nvim
vim.api.nvim_create_autocmd('TermOpen', {
    pattern = "*",
    command = "set nonumber norelativenumber"
})

-- Treesitter folding
vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
        local ok = pcall(vim.treesitter.start, args.buf)

        if ok then
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        else
            vim.opt_local.foldmethod = "syntax"
        end
    end,
})
