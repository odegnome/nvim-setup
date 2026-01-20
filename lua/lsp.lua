require('mason').setup({
    PATH = "append",
})

require('mason-lspconfig').setup({
    ensure_installed = { 'rust_analyzer', 'lua_ls', 'pyright' },
    automatic_enable = false,
})

-- Set different settings for different languages' LSP
-- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
--     - the settings table is sent to the LSP
--     - on_attach: a lua callback function to run after LSP attaches to a given buffer
-- !------- DEPRECATED - Remove in future -------!
-- local lspconfig = require('lspconfig')
-- local util = require('lspconfig/util')

-- Customized on_attach function
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>dl', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<space>dq', vim.diagnostic.setqflist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', 'qf', function()
        vim.lsp.buf.format({ async = true })
    end, bufopts)

    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
end
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure how the hover window looks like
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover,
    {
        border = "rounded",
        max_width = math.floor(vim.o.columns * 0.5),
        max_height = 50,
        wrap = true,
    }
)

-- Configure each language
-- How to add LSP for a specific language?
-- 1. use `:Mason` to install corresponding LSP
-- 2. add configuration below
vim.lsp.config("rust_analyzer", {
    on_attach = on_attach,
    filetypes = { "rust" },
    -- root_dir = util.root_pattern("Cargo.toml"),
    settings = {
        ['rust-analyzer'] = {
            cargo = {
                allFeatures = true,
                buildScripts = {
                    enable = true,
                },
                procMacro = {
                    enable = true,
                },
            },
            check = {
                -- alternative: "clippy"
                command = "clippy",
            },
            diagnostics = {
                disabled = { "unlinked-file" },
            },
            completion = {
                addCallArgumentSnippets = true,
                addCallParenthesis = true,
            },
        },
    },
    capabilities = capabilities,
    init_options = {
        positionEncodings = { "utf-8" },
    },
})

vim.lsp.config("lua_ls", {
    on_attach = on_attach,
    filetypes = { "lua" },
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

vim.lsp.config("pyright", {
    on_attach = on_attach,
    filetypes = { "python" },
    capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
    on_attach = on_attach,
    -- filetypes = { "json", "javascript", "typescript" }, -- default filetypes are being used.
    capabilities = capabilities,
})

vim.lsp.config("html", {
    on_attach = on_attach,
    capabilities = capabilities,
    single_file_support = true,
})

vim.lsp.config("cssls", {
    on_attach = on_attach,
    capabilities = capabilities,
})

-- ! ONLY SET WHEN USING coplit.lua & not copilot.vim !
-- vim.lsp.config("copilot", {
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })

-- Enable all configured servers
vim.lsp.enable({ 'rust_analyzer', 'lua_ls', 'pyright', 'ts_ls', 'html', 'cssls' })

require('luasnip.loaders.from_vscode').lazy_load()
