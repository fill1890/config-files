return {
    'Chaitanyabsprip/fastaction.nvim',
    opts = {},
    init = function ()
        vim.keymap.set('n', '<Leader>k', '<cmd>lua require("fastaction").code_action()<CR>')
    end
}
