-- ============================================================================
-- plugins/repl.lua: send code to a running REPL
-- ============================================================================
-- https://github.com/Vigemus/iron.nvim
-- Works for Julia, Python and Octave. The REPL opens in a split below.
--
--   <leader>rr  open / close the REPL        <leader>rR  restart it
--   <leader>rl  send the current line        <leader>rp  send the paragraph
--   <leader>rc  send a motion (e.g. <leader>rcip), or the visual selection
--   <leader>rf  send the whole file          <leader>ru  send up to the cursor
--   <leader>rb  send the code cell           <leader>rn  send cell, go to next
--   <leader>ro  focus the REPL               <leader>rh  hide the REPL
--   <leader>r<space>  interrupt              <leader>rq  quit the REPL
--   <leader>rx  clear the REPL
-- Code cells are separated by lines starting with  # %%  (or  %%  in Octave).

return {
  "Vigemus/iron.nvim",
  ft = { "python", "julia", "octave" }, -- load when one of these files opens
  cmd = { "IronRepl" },

  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        scratch_repl = true, -- REPL buffers are thrown away when closed
        repl_open_cmd = view.bottom(15),
        repl_definition = {
          python = {
            command = { "python3" }, -- or { "ipython", "--no-autoindent" }
            format = common.bracketed_paste_python,
            block_dividers = { "# %%", "#%%" },
            env = { PYTHON_BASIC_REPL = "1" }, -- needed for Python 3.13+
          },
          julia = {
            command = { "julia" },
            block_dividers = { "# %%", "#%%", "##" },
          },
          octave = {
            command = { "octave", "--no-gui", "--quiet" },
            block_dividers = { "%%", "# %%" },
          },
        },
      },

      keymaps = {
        toggle_repl = "<leader>rr",
        restart_repl = "<leader>rR",
        send_line = "<leader>rl",
        send_paragraph = "<leader>rp",
        send_motion = "<leader>rc",
        visual_send = "<leader>rc",
        send_file = "<leader>rf",
        send_until_cursor = "<leader>ru",
        send_code_block = "<leader>rb",
        send_code_block_and_move = "<leader>rn",
        interrupt = "<leader>r<space>",
        exit = "<leader>rq",
        clear = "<leader>rx",
      },

      highlight = { italic = true },
      ignore_blank_lines = true,
    })

    vim.keymap.set("n", "<leader>ro", "<cmd>IronFocus<cr>", { desc = "REPL: focus" })
    vim.keymap.set("n", "<leader>rh", "<cmd>IronHide<cr>", { desc = "REPL: hide" })
  end,
}
