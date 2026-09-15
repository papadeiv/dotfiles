-- ============================================================================
-- plugins/claude.lua: Claude Code inside Neovim
-- ============================================================================
-- https://github.com/coder/claudecode.nvim
-- Requires the Claude Code CLI (`claude` on your PATH), signed in with your
-- subscription. Claude opens in a split on the right and can see your open
-- files and selections; proposed edits open as diffs you accept or reject.
--
-- If `claude` isn't found (e.g. a local install), set terminal_cmd below to
-- the output of `which claude`.

return {
  "coder/claudecode.nvim",

  cmd = {
    "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeSelectModel", "ClaudeCodeAdd",
    "ClaudeCodeSend", "ClaudeCodeStatus", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny",
  },

  keys = {
    { "<leader>ic", "<cmd>ClaudeCode<cr>", desc = "Claude: toggle" },
    { "<leader>if", "<cmd>ClaudeCodeFocus<cr>", desc = "Claude: focus" },
    { "<leader>ir", "<cmd>ClaudeCode --resume<cr>", desc = "Claude: resume a past session" },
    { "<leader>iC", "<cmd>ClaudeCode --continue<cr>", desc = "Claude: continue last session" },
    { "<leader>im", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Claude: select model" },
    { "<leader>ib", "<cmd>ClaudeCodeAdd %<cr>", desc = "Claude: add current file" },
    { "<leader>is", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Claude: send selection" },
    { "<leader>ia", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Claude: accept diff" },
    { "<leader>id", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Claude: reject diff" },
  },

  opts = {
    -- terminal_cmd = "~/.claude/local/claude",
    terminal = {
      provider = "native", -- Neovim's own terminal, no extra plugin needed
      split_side = "right",
      split_width_percentage = 0.35,
    },
  },
}
