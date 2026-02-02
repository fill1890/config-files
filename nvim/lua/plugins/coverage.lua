return {
    'andythigpen/nvim-coverage',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {},
    lazy = false,
    init = function ()
        vim.api.nvim_create_autocmd({"BufReadPost"}, {
            pattern = "*.py",
            callback = require('coverage').load,
        })
    end
}
