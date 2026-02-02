local M = {}

function M.setup()
    local packer_bootstrap = false

    local conf = {
        display = {
            open_fn = function()
                return require'packer.util'.float { border = 'rounded' }
            end
        }
    }

    -- check if packer if needed
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath('data').. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            vim.cmd [[packadd packer.vim]]
        end

        -- recompile if file changed
        vim.cmd "autocmd BufWritePost packer.lua source <afile> | PackerCompile"
    end

    local function plugins(use)
        -- packer
        use { 'wbthomason/packer.nvim' }

        -- status line
        require'plugins.lualine'.setup(use)

        -- onedark theme
        require'plugins.onedark'.setup(use)

        -- autocomplete
        require'plugins.coq'.setup(use)

        -- lsp setup - autocomplete
        require'plugins.lspconfig'.setup(use)

        -- lsp installer
        require'plugins.mason'.setup(use)

        -- arduino syntax
        use { 'sudar/vim-arduino-syntax' }

        -- treesitter - highlighting, indenting, etc
        require'plugins.treesitter'.setup(use)

        -- autopairs
        require'plugins.autopairs'.setup(use)

        -- filetree
        --require'plugins.tree'.setup(use)
        -- resume editing
        use { 'farmergreg/vim-lastplace' }

        -- context
        use { 'nvim-treesitter/nvim-treesitter-context' }

        -- floating terminal
        require'plugins.floaterm'.setup(use)

        -- tabline
        require'plugins.tabline'.setup(use)

        -- surround
        require'plugins.surround'.setup(use)

        -- comment toggling
        require'plugins.comment'.setup(use)

        -- fun trouble things
        require'plugins.trouble'.setup(use)

        require'plugins.neogen'.setup(use)

        require'plugins.hover'.setup(use)

        require'plugins.join'.setup(use)

        require'plugins.overlength'.setup(use)

        require'plugins.guess-indent'.setup(use)

        -- matching of token under cursor
        -- caused high CPU use on large files
        --use { 'RRethy/vim-illuminate' }

        -- highlight trailing whitespace
        require'plugins.whitespace'.setup(use)

        if packer_bootstrap then
            print "Restart required after install!"
            require'packer'.sync()
        end
    end

    packer_init()

    local packer = require'packer'
    packer.init(conf)
    packer.startup(plugins)
end

return M
