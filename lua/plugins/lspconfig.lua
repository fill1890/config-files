local remap = vim.keymap.set
local keybinds = function(client, bufnr) local opts = { noremap = true, silent = true, buffer = bufnr }

    remap('n', 'K', vim.lsp.buf.hover, opts)
end

return {
    'neovim/nvim-lspconfig',

    opts = {
        servers = {
            clangd = {},
            basedpyright = {},
            ltex = {
                settings = {ltex = {
                    language = 'en-AU',
                    enabled = {
                        'latex', 'markdown', 'restructuredtext',
                        'python',
                    }
                }},
                filetypes = {
                    'bib', 'gitcommit', 'markdown', 'org', 'plaintex',
                    'tex', 'rst', 'pandoc', 'lua',
                },
            },
            lua_ls = {},
        },
        inlay_hints = { enabled = true },
    },

    config = function(_, opts)
        require('mason').setup()
        require('mason-lspconfig').setup()
        local lsp = require'lspconfig'
        for server, config in pairs(opts.servers) do
            -- passing config.capabilities to blink.cmp merges with the capabilities in your
            -- `opts[server].capabilities, if you've defined it
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lsp[server].setup(config)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, {bufnr = args.buf})
                end
                -- whatever other lsp config you want
            end
        })
    end,

    dependencies = {
        { 'saghen/blink.cmp' },
        { 'williamboman/mason-lspconfig.nvim' }
    },

    init = function()
    end,

    lazy = false,
}

