-- ============================================================================
-- plugins/neo-tree.lua: file navigator
-- ============================================================================
-- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- All of neo-tree's default keys are switched off. Inside the tree only:
--   i  open a file / open or close a folder
--   a  create a file (end the name with / to create a folder)
--   r  rename
--   d  delete (asks for confirmation)
--   x  cut      c  copy      p  paste (into the folder under the cursor)
--   H  show / hide hidden files
-- To add more, see the list of commands in `:help neo-tree-mappings`.

-- Sort folders first, then by file extension, then by name
-- (matches the "filetype" sorting from the previous nvim-tree setup).
local function sort_by_type(a, b)
  if a.type ~= b.type then
    return a.type == "directory"
  end
  local ext_a = vim.fn.fnamemodify(a.path, ":e"):lower()
  local ext_b = vim.fn.fnamemodify(b.path, ":e"):lower()
  if ext_a ~= ext_b then
    return ext_a < ext_b
  end
  return a.path:lower() < b.path:lower()
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false, -- neo-tree loads itself lazily; also lets `nvim .` open the tree

  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file navigator" },
  },

  opts = {
    close_if_last_window = false, -- <leader>q on the last file leaves the tree open
    -- Never open a file into these windows (the minimap is not a text window)
    open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "neominimap" },
    use_default_mappings = false, -- start from zero keys
    sort_function = sort_by_type,

    window = {
      position = "left",
      width = 30,
      mappings = {
        ["i"] = "open",
        ["a"] = "add",
        ["r"] = "rename",
        ["d"] = "delete",
        ["x"] = "cut_to_clipboard",
        ["c"] = "copy_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["H"] = "toggle_hidden", -- show / hide dotfiles and gitignored files
      },
    },

    filesystem = {
      follow_current_file = { enabled = true }, -- highlight the file you're editing
      group_empty_dirs = true,       -- show a/b/c as one line when folders are empty
      use_libuv_file_watcher = true, -- refresh automatically when files change
      filtered_items = {
        hide_dotfiles = true,
        hide_gitignored = true,
        -- Don't add "(N hidden items)" rows: they break the tree's guide lines
        show_hidden_count = false,
      },
    },
  },
}
