return {
    "romus204/tree-sitter-manager.nvim",

    config = function()

        require("tree-sitter-manager").setup({
            ensure_installed = {
                "c",
                "java",
                "javascript",
                "python",
                "cpp",
                "make",
                "vim",
                "lua",
                "markdown",
                "markdown_inline",
            }
        })

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

