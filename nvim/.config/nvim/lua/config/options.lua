-- Leader must be set before lazy.setup so plugin `keys` resolve <leader> correctly
vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.completeopt = { "menu", "menuone", "preview", "noselect", "noinsert" }

-- Cursor
vim.opt.guicursor = {
  "n-v-c:block-Cursor",
  "i:ver100-iCursor",
  "n-v-c:blinkon0",
  "i:blinkwait10",
}

-- File browser (netrw)
vim.g.netrw_browse_split = 3
vim.g.netrw_list_hide = [[\(^\|\s\s\)\zs\.\S\+]]

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Backup & Undo
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")

-- Display
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.mat = 5
vim.opt.foldcolumn = "0"
-- CursorHold delay (default 4000ms); drives Trouble's follow-the-cursor refresh
vim.opt.updatetime = 300

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true

-- Search
vim.opt.smartcase = true
vim.opt.clipboard = "unnamed"

-- Command line
vim.opt.wildmenu = true
vim.opt.wildmode = { "longest:full", "full" }
vim.opt.wildignore:append({
  "*/node_modules/*", "_site", "*/__pycache__/*", "*/venv/*", "*/target/*",
  "*/.vim$", "~$", "*/.log", "*/.aux", "*/.cls", "*/.bbl", "*/.blg",
  "*/.fls", "*/.fdb*", "*/.toc", "*/.out", "*/.glo", "*/.ist", "*/.fdb_latexmk",
})

-- Backspace behavior
vim.opt.backspace = { "indent", "eol", "start" }

-- Ag
vim.g.ackprg = "ag --vimgrep"
