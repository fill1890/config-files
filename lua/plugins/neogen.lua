return {
    'danymat/neogen',
    config = true,
    dependencies = 'nvim-treesitter/nvim-treesitter',

    init = function()
        vim.keymap.set('n', '<Leader>d', require('neogen').generate, { desc = 'Neogen: Generate autodoc' })
    end,
}

