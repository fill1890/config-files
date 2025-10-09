return {
    'navarasu/onedark.nvim',
    main = 'onedark',
    opts = {
        style = 'warmer',
        --style = 'light',
        --colors = {
        --    bg0 = "#e9e9e9",
        --    bg1 = "#e0e0e0",
        --    bg2 = "#dcdcdc",
        --    bg3 = "#cdcdcd",
        --    bg_d = "#b0b0b0"
        --}
    },
    init = function()
        require('onedark').load()
    end,
    priority = 1000,
}

