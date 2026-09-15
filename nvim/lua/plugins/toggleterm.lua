-- ============================================================================
-- plugins/toggleterm.lua: terminals inside Neovim
-- ============================================================================
-- https://github.com/akinsho/toggleterm.nvim

return {
  "akinsho/toggleterm.nvim",
  version = "*",

  keys = {
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Floating terminal" },
    { "<leader>th", "<cmd>ToggleTerm size=20 direction=horizontal<cr>", desc = "Horizontal terminal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical terminal" },
  },

  opts = {
    hide_numbers = true,
    insert_mappings = true,
    start_in_insert = true,
    auto_scroll = true,
    persist_size = true,
  },

  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- <Esc> leaves terminal mode in every terminal buffer...
    vim.api.nvim_create_autocmd("TermOpen", {
      group = vim.api.nvim_create_augroup("terminal_esc", { clear = true }),
      pattern = "term://*",
      callback = function(args)
        -- ...except Claude Code's, where <Esc> must reach Claude to interrupt it.
        -- Terminal buffer names look like  term://<cwd>//<pid>:<command>
        local command = vim.api.nvim_buf_get_name(args.buf):match("//%d+:(.*)$") or ""
        if command:match("claude") then
          return
        end
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { buffer = args.buf, desc = "Leave terminal mode" })
      end,
    })
  end,
}
