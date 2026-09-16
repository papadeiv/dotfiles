-- ============================================================================
-- plugins/markdown.lua: rendered Markdown inside Neovim
-- ============================================================================
-- https://github.com/MeanderingProgrammer/render-markdown.nvim
--
-- Markdown files open rendered: headings, code blocks, tables, checkboxes,
-- quotes and links are drawn in place. The line under the cursor shows raw
-- text so you can edit it.
--   <leader>m  switch between rendered and raw

return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" }, -- load when a Markdown file opens

  keys = {
    { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle rendered / raw Markdown" },
  },

  opts = {},
}
