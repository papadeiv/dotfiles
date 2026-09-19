-- ============================================================================
-- plugins/telescope.lua: fuzzy finder
-- ============================================================================
-- https://github.com/nvim-telescope/telescope.nvim
-- Searching the current file needs nothing extra; searching the whole project
-- needs ripgrep:  pacman -S ripgrep  /  apt install ripgrep
--
--   <leader>f  search the file you're in, and jump between the matches
--   <leader>F  find files by name (in the project)
--   <leader>B  switch between open files (<leader>b toggles the minimap)
--   <leader>g  search text across every file in the project (needs ripgrep)
--
-- Inside the box (while typing):
--   <S-j> / <S-k>  next / previous match, with a preview
--   <S-i>          open the highlighted match
--   <C-q>          put every match in the quickfix list, for :cfdo search and replace
--   <Esc>          close and go back to what you were doing

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",

  keys = {
    { "<leader>f", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search this file" },
    { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Search text in project" },
    { "<leader>F", "<cmd>Telescope find_files<cr>", desc = "Find files by name" },
    { "<leader>B", "<cmd>Telescope buffers<cr>", desc = "Open files" },
  },

  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = " ",
        path_display = { "truncate" },
        sorting_strategy = "ascending", -- best match at the top
        layout_config = {
          prompt_position = "top",
          horizontal = { preview_width = 0.55 },
        },
        mappings = {
          i = { -- while typing
            ["<S-j>"] = actions.move_selection_next,
            ["<S-k>"] = actions.move_selection_previous,
            ["<S-i>"] = actions.select_default,
            ["<esc>"] = actions.close, -- one press closes the box
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
          n = { -- if you ever end up in normal mode inside the box
            ["<esc>"] = actions.close,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = { hidden = true }, -- include dotfiles
        current_buffer_fuzzy_find = {
          skip_empty_lines = true,
          previewer = false, -- the file is already on screen behind the box
          layout_config = { width = 0.6, height = 0.5 },
        },
      },
    })
  end,
}
