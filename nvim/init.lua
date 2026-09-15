-- ============================================================================
-- init.lua: entry point
-- ============================================================================
-- This file only loads the modules below, in order. Each module has one job:
--
--   core/options.lua   editor settings (line numbers, tabs, clipboard, ...)
--   core/keymaps.lua   global keybindings that don't belong to a plugin
--   core/autocmds.lua  small automatic behaviours (yank highlight, ...)
--   core/lazy.lua      installs lazy.nvim and loads every file in lua/plugins/
--
-- To add a plugin, create a new file in lua/plugins/. To remove one, delete
-- its file. Nothing else needs to change.
-- ============================================================================

require("core.options") -- must come first: it sets the leader key
require("core.keymaps")
require("core.autocmds")
require("core.lazy")
