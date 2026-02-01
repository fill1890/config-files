return {
    'stevearc/conform.nvim',
    opts = {
        formatters_by_ft = {
            jinja = { 'djlint' },
            python = { 'ruff_format' },
            css = { 'prettierd', 'prettier' },
            javascript = { 'prettierd', 'prettier' },
            markdown = { 'rumdl' },
        }
    },
    init = function ()
        vim.keymap.set('n', '<Leader>f', require('conform').format, { desc = 'Conform: format' })
        vim.api.nvim_create_autocmd({ "BufWritePre", }, {
            pattern = '*',
            callback = function(args)
                -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- for the current filetype
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end
}

