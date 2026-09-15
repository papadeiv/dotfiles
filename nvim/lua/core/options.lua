-- ============================================================================
-- core/options.lua: editor settings
-- ============================================================================
-- See `:help option-list` for what any option does.

local opt = vim.opt

-- Leader keys ------------------------------------------------------------------
-- Must be set before any mapping that uses <leader> is created.
vim.g.mapleader = " "        -- <leader> is Space
vim.g.maplocalleader = "\\"  -- <localleader> is backslash (used by vimtex)

-- Line numbers -----------------------------------------------------------------
-- Both on = hybrid: the cursor line shows its real number, the others show
-- their distance from the cursor.
opt.number = true
opt.relativenumber = true
opt.cursorline = true -- needed for the cursor line-number highlight

-- Indentation ------------------------------------------------------------------
opt.expandtab = true -- insert spaces, not tab characters
opt.tabstop = 2      -- a tab character is shown as 2 columns
opt.shiftwidth = 2   -- >>, << and auto-indent move by 2 columns
opt.softtabstop = 2  -- <Tab>/<BS> in insert mode work in steps of 2
vim.g.python_recommended_style = 0 -- stop Python files from switching to 4 spaces

-- Quality of life --------------------------------------------------------------
opt.backspace = { "indent", "eol", "start" } -- backspace over anything
opt.showcmd = true
opt.undofile = true   -- keep undo history after closing a file
opt.ignorecase = true -- case-insensitive search...
opt.smartcase = true  -- ...unless the search contains a capital letter
opt.splitright = true -- vertical splits open on the right
opt.splitbelow = true -- horizontal splits open below
opt.scrolloff = 4     -- keep a few lines visible above/below the cursor
opt.updatetime = 250  -- faster CursorHold events (diagnostic popups etc.)

-- Share the system clipboard (yank in Neovim, paste anywhere and vice versa).
-- Scheduled because detecting the clipboard tool can slow down startup.
vim.schedule(function()
  opt.clipboard = "unnamedplus"
end)

-- Appearance -------------------------------------------------------------------
opt.termguicolors = true            -- 24-bit colours (needed by catppuccin)
opt.fillchars:append({ eob = " " }) -- hide the ~ after the end of a file

-- Filetypes --------------------------------------------------------------------
-- Treat every .m file as GNU Octave (otherwise Neovim guesses between
-- Objective-C, MATLAB, Octave, ...).
vim.filetype.add({
  extension = { m = "octave" },
})
