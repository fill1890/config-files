local function rule_padout(a1,ins,a2,lang)
    local cond = require('nvim-autopairs.conds')

    require('nvim-autopairs').add_rule(
        require('nvim-autopairs.rule')(ins, ins, lang)
        :with_pair(function(opts) return a1..a2 == opts.line:sub(opts.col - #a1, opts.col + #a2 - 1) end)
        :with_move(cond.none())
        :with_cr(cond.none())
        :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            return a1..ins..ins..a2 == opts.line:sub(col - #a1 - #ins + 1, col + #ins + #a2) -- insert only works for #ins == 1 anyway
        end)
    )
end

return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
        map_bs = false,
        map_cs = false,
        check_ts = true,
    },
    init = function()
        rule_padout('{', '%', '}', { 'html.jinja' })
        rule_padout('{%', ' ', '%}', { 'html.jinja' })
        rule_padout('{{', ' ', '}}', { 'html.jinja' })
    end,
}

