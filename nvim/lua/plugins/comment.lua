return {
    'numToStr/Comment.nvim',
    opts = {
        padding = false,
        ignore = '^$',
    },
    init = function()
        vim.keymap.set('n', '?', function()
            return vim.v.count == 0
                and '<Plug>(comment_toggle_linewise_current)'
                or '<Plug>(comment_toggle_linewise_count)'
        end, { desc = 'Comment.nvim: Toggle comment' })
    end
}

