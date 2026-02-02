return {
    '3rd/diagram.nvim',
    dependencies = '3rd/image.nvim',
    enabled = false,
    init = function()
        require('diagram').setup({
            integrations = {
                require('diagram.integrations.markdown')
            },
        })
    end,
}
