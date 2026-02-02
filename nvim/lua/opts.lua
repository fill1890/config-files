local opt = vim.opt

opt.background = 'dark'                 -- dark bg

-- Setup

opt.backupdir = '/tmp'                  -- directory setup
opt.directory = '/tmp'
opt.encoding = 'utf-8'

opt.wildmenu = true                     -- command completion

-- Tabs

opt.shiftround = true                   -- round <Tab> to tabs
opt.tabstop = 4                         -- 4 space tab character
opt.softtabstop = 4                     -- 4 space <Tab> key
opt.shiftwidth = 4                      -- 4 space auto indent
opt.expandtab = true                    -- spaces instead of tabs

-- UI Config

opt.modelines = 1                       -- check for 1 vim settings line
opt.scrolloff = 8                       -- min 8 lines top/bottom
opt.splitright = true
opt.splitbelow = true
opt.showcmd = true                      -- show commands while entering
opt.cursorline = true
opt.ruler = true
opt.title = true
opt.laststatus = 2
opt.lazyredraw = true
opt.relativenumber = true
opt.number = true
opt.ttimeoutlen = 10

-- Searching

opt.gdefault = true                     -- auto /g on substitute
opt.incsearch = true                    -- incremental searching
opt.showmatch = true                    -- show matching brackets

-- Folding

opt.foldenable = true
opt.foldlevelstart = 10
opt.foldnestmax = 10

-- Spell check
opt.spelllang = 'en_au'

opt.bs = 'indent,start'

vim.cmd([[command SortImports %s/import\s*\zs.*/\=join(sort(split(submatch(0), '\s*,\s*')),', ')]])

vim.filetype.add({
    extension = {
        jinja = 'html.jinja',
        jinja2 = 'html.jinja',
        j2 = 'html.jinja',
    },
    pattern = {
        ['.*templates/.*%.html'] = 'html.jinja',
    }
})

