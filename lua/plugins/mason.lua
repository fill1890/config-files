return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
        priority = 500,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        dependencies = 'williamboman/mason.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        opts = {
            automatic_installation = false,
        },
        config = true,
        lazy = false,
        priority = 400, -- after mason.nvim
    }
}
