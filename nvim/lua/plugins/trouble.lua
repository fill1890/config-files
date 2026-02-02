return {
    'folke/trouble.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    keys = {
        { '<Leader>t', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>'}
    },
    opts = {
        mode = 'disgnostics',
    },
}
