return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',

    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            ensure_installed = {
                "c",
                "java",
                "javascript",
                "python",
                "cpp",
                "make",
                "markdown",
                "vim",
                "lua",
                "markdown_inline",
            },
            highlight = {
                enable = true,
            },
            sync_install = false,
        })
    end,

    init = function()
        vim.cmd 'set autoindent'
        vim.cmd 'filetype plugin indent on'

        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

        vim.api.nvim_create_autocmd('FileType', {
            pattern = {'html', 'html.jinja', '*.jinja', 'jinja'},
            callback = function(args)
                vim.treesitter.stop(args.buf)
            end
        })
    end,
}

