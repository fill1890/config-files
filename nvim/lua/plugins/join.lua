return {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
        vim.keymap.set('n', '<Leader>j', require('treesj').join, { desc = 'TreeSJ: Join lines' })
        vim.keymap.set('n', '<Leader>s', require('treesj').split, { desc = 'TreeSJ: Split line' })
    end,
    opts = {
        use_default_keymaps = false,
    },
}
