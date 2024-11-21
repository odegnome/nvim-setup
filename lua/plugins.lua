local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true,
        -- opts = {},
    },

    -- Snippet
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },

    -- LSP manager
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python"},
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
                autopairs = { enable = true },
            })
        end
    },

    -- Commenting plugin
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    -- shows the autocomplete menu
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-buffer", -- source for text in buffer
            "hrsh7th/cmp-path", -- source for file system paths in commands
            'hrsh7th/cmp-nvim-lsp', -- source for lsp
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require('luasnip')

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect",
                },
                snippet = {
                  expand = function(args)
                    luasnip.lsp_expand(args.body)
                  end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-f>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-b>"] = cmp.mapping.scroll_docs(4),
                    ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
                    ["<C-y>"] = cmp.mapping.confirm({ select = false }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" }, -- file system paths
                }),
            })
        end,
    },
})
