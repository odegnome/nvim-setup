local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "git@github.com:folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Java all-inclusive setup
    -- "nvim-java/nvim-java",

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
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "rust", "python" },
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
            'hrsh7th/cmp-nvim-lsp', -- source for lsp
            "hrsh7th/cmp-buffer",   -- source for text in buffer
            "hrsh7th/cmp-path",     -- source for file system paths in commands
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require('luasnip')

            cmp.setup({
                completion = {
                    completeopt = "menu,menuone,preview,noselect,popup",
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(), -- previous suggestion
                    ["<C-n>"] = cmp.mapping.select_next_item(), -- next suggestion
                    ["<C-h>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-b>"] = cmp.mapping.scroll_docs(4),
                    ["<C-space>"] = cmp.mapping.complete(), -- show completion suggestions
                    ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
                    ["<C-y>"] = cmp.mapping.confirm({ select = false }),
                }),
                -- sources for autocompletion
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = "buffer" }, -- text within current buffer
                    { name = "path" },   -- file system paths
                }),
                -- Window size options
                window = {
                    completion = cmp.config.window.bordered({
                        border = "rounded",
                        winblend = 50,
                    }),
                    documentation = cmp.config.window.bordered({
                        border = "rounded",
                        winblend = 50,
                    }),
                },
                formatting = {
                    fields = { "abbr", "menu", "kind" },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "NLSP",
                            nvim_lua = "NLUA",
                            luasnip  = "LSNP",
                            buffer   = "BUFF",
                            path     = "PATH",
                        }
                        item.menu = menu_icon[entry.source.name]
                        local fixed_width = 40
                        vim.o.pumwidth = fixed_width
                        local max_content_width = fixed_width - 10
                        local content = item.abbr
                        if #content > max_content_width then
                            item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
                        else
                            item.abbr = content .. string.rep(" ", max_content_width - #content)
                        end
                        return item
                    end,
                }
            })
        end,
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },

    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_enabled = true
        end
    },

    {
        "tpope/vim-fugitive",
    },

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            {
                "nvim-lua/plenary.nvim"
            },
            {
                "github/copilot.vim"
            }
        },
        build = "make tiktoken",
        opts = {
        }

    }
})
