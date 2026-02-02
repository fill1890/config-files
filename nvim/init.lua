local cmd = vim.api.nvim_command
local remap = vim.api.nvim_set_keymap

-- Plugins
--require 'packer_init'.setup()
require 'config.lazy'

-- Imports

require 'keys'
require 'opts'
-- Commands
-- 256 colour
cmd('set t_Co=256')

-- highlight extra whitespace on a line
cmd('highlight ExtraWhitespace ctermbg=red guibg=red')
cmd([[match ExtraWhitespace /\s\+$/]])

-- highlight characters past a certain length
cmd('highlight ColorColumn ctermbg=168')
-- italic comments
cmd('highlight Comment cterm=italic')

-- help in a vertical window
cmd([[autocmd! BufEnter * if &ft ==# 'help' | wincmd L | endif]])

cmd('autocmd FileType markdown setlocal spell')
cmd('autocmd FileType gitcommit setlocal spell')

-- Autopair keybinding {{{

-- these mappings are coq recommended mappings unrelated to nvim-autopairs
local npairs = require('nvim-autopairs')

remap('i', '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
remap('i', '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
remap('i', '<tab>', [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
remap('i', '<s-tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

_G.MUtils = {}

MUtils.CR = function()
    if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
            return npairs.esc('<c-y>')
        else
            return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
    else
        return npairs.autopairs_cr()
    end
end
remap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

MUtils.BS = function()
    if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
    else
        return npairs.autopairs_bs()
    end
end
remap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })

-- }}}

-- vim:foldmethod=marker:foldlevel=0
