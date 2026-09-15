-- ============================================================================
-- core/autocmds.lua: small automatic behaviours
-- ============================================================================
-- Autocommands run code when an event happens (see `:help autocmd-events`).

local group = vim.api.nvim_create_augroup("core_autocmds", { clear = true })

-- Briefly highlight text after yanking it.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- When reopening a file, jump back to where the cursor was last time.
vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
