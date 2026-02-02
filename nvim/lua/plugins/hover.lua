return {
    'lewis6991/hover.nvim',
    opts = {
        init = function()
            require 'hover.providers.lsp'
            require 'hover.providers.man'
        end,
    },
    init = function()
        vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
    end,
}

