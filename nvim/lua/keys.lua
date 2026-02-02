local remap = vim.api.nvim_set_keymap
local kremap = vim.keymap.set

local noremap = { noremap = true }

-- Insert mode {{{

-- use jk to exit insert mode
remap('i', 'jk', '<Esc>', noremap)

--- }}}

-- Normal mode {{{

-- space to open/close folds
remap('n', '<space>', 'za', noremap)

-- LSP keybinds
-- gd and gD to go to definition/declaration
kremap('n', 'gd', vim.lsp.buf.definition, noremap)
kremap('n', 'gD', vim.lsp.buf.declaration, noremap)
-- gi to go to implementation
kremap('n', 'gi', vim.lsp.buf.implementation, noremap)
-- \c to rename
kremap('n', '<Leader>c', vim.lsp.buf.rename, noremap)

-- use \r to run files with a shebang line
remap('n', '<Leader>r', '<cmd>!./%<CR>', noremap)
-- use \ev to edit vimrc
remap('n', '<Leader>ev', '<cmd>vsp $MYVIMRC<CR>', noremap)
-- use \sv to source vimrc
remap('n', '<Leader>sv', '<cmd>source $MYVIMRC<CR>', noremap)
remap('n', '?', 'gcc', {})
-- use \n to toggle relative numbers
remap('n', '<Leader>n', '<cmd>set rnu!<CR>', {})

-- }}}

-- vim:foldmethod=marker:foldlevel=0
