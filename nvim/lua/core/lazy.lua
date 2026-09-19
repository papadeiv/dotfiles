-- ============================================================================
-- core/lazy.lua: plugin manager
-- ============================================================================
-- Installs lazy.nvim on first start, then loads every file in lua/plugins/.
-- Useful commands:  :Lazy  (open the UI)   :Lazy sync  (install + update + clean)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n" .. out, "ErrorMsg" } }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },            -- load every file in lua/plugins/
  install = { colorscheme = { "cyberdream", "habamax" } }, -- theme shown during the first install
  checker = { enabled = false },                -- don't check for updates in the background
  change_detection = { notify = false },        -- reload silently when a config file changes
  rocks = { enabled = false },                  -- no plugin here needs luarocks
})
