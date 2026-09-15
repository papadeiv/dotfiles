-- ============================================================================
-- core/keymaps.lua: global keybindings
-- ============================================================================
-- Only keybindings that don't depend on a plugin live here. Plugin keybindings
-- live in that plugin's file in lua/plugins/ (look for `keys = {...}`), so that
-- removing a plugin also removes its keys.
--
-- A full list of every custom keybinding is in README.md.

local map = vim.keymap.set

-- Motions ----------------------------------------------------------------------
map("n", "q", "o", { desc = "Open a new line below" })
map("n", "1", "0", { desc = "Go to start of line" })
map("n", "2", "$", { desc = "Go to end of line" })

-- `q` is taken above, so macro recording moves here.
-- Usage: <leader>ma ...edits... <leader>m  records into register a; replay with @a
map("n", "<leader>m", "q", { desc = "Record macro" })

-- Windows ----------------------------------------------------------------------
-- Move to the previous window: with the tree and one file open, this switches
-- between them. Floating windows (minimap, popups) are skipped.
-- (In insert mode <S-Tab> is still the snippet jump.)
map("n", "<S-Tab>", function()
  local wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_get_config(win).relative == "" -- not floating
  end, vim.api.nvim_tabpage_list_wins(0))

  local current = vim.api.nvim_get_current_win()
  local target = wins[1]
  for i, win in ipairs(wins) do
    if win == current then
      target = wins[i - 1] or wins[#wins] -- previous, wrapping around
      break
    end
  end
  vim.api.nvim_set_current_win(target)
end, { desc = "Previous window" })

-- Files ------------------------------------------------------------------------
map("n", "<leader>w", "<cmd>w!<cr>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q!<cr>", { desc = "Quit without saving" })
map("n", "<leader>/", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
