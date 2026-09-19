-- ============================================================================
-- plugins/minimap.lua: code minimap
-- ============================================================================
-- https://github.com/Isrothy/neominimap.nvim
--
-- A full-height braille map of the file in a narrow split on the right,
-- coloured by treesitter, with the current line marked and errors, warnings,
-- search matches and git changes shown on it.
--
--   <leader>b  show / hide the minimap
--   <leader>h  move the cursor into / out of the minimap
-- While the cursor is in the minimap, j / k / <C-d> / <C-u> / gg / G move
-- through the file.

return {
  "Isrothy/neominimap.nvim",
  version = "v3.x.x",
  lazy = false, -- the plugin loads itself lazily

  keys = {
    { "<leader>b", "<cmd>Neominimap Toggle<cr>", desc = "Toggle minimap" },
    { "<leader>h", "<cmd>Neominimap ToggleFocus<cr>", desc = "Focus / unfocus minimap" },
  },

  -- neominimap reads its settings from vim.g.neominimap before loading
  init = function()
    vim.g.neominimap = {
      auto_enable = true,
      layout = "split", -- beside the text, not on top of it

      -- "percent": the minimap position follows the position in the file
      -- "center":  the current line stays in the middle of the minimap
      current_line_position = "percent",

      split = {
        minimap_width = 20,   -- columns of braille (each is 2 characters wide)
        fix_width = true,     -- don't let other splits resize it
        direction = "right",
        close_if_last_window = true,
      },

      click = { enabled = false }, -- no mouse interaction

      -- Syntax colours, taken from treesitter (this is what makes the map
      -- look like the plugin's screenshots). neominimap applies them in the
      -- background, so if the file changes while it's working it can throw
      -- "Invalid 'line': out of range". Set to false if that gets annoying.
      treesitter = { enabled = true },

      -- Marks on the map
      diagnostic = { enabled = true },  -- errors and warnings
      search = { enabled = true },      -- search matches
      git = { enabled = true },         -- added / changed / removed lines

      -- Give the background work a moment to settle, which makes the error
      -- above much less likely
      delay = 400,

      exclude_filetypes = { "help", "neo-tree", "toggleterm", "lazy", "mason", "alpha" },
    }

    -- Colours: transparent background, current line marked with the theme's
    -- selection colour. The border colour is NOT set here: colorscheme.lua
    -- owns NeominimapBorder (along with the tree lines and separators), so
    -- every accent colour comes from one place.
    local function set_highlights()
      local function color(group, attr, fallback)
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
        return hl[attr] and string.format("#%06x", hl[attr]) or fallback
      end
      vim.api.nvim_set_hl(0, "NeominimapBackground", { bg = "NONE" }) -- transparent map
      vim.api.nvim_set_hl(0, "NeominimapCursorLine", { bg = color("Visual", "bg", "#3c4048") })
    end

    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

    -- Keep the minimap off when there's no file on screen: on the start screen,
    -- and after closing the last file while the tree stays open.
    local group = vim.api.nvim_create_augroup("minimap_visibility", { clear = true })
    local disabled = false

    local function enable()
      if disabled then
        disabled = false
        vim.cmd("Neominimap Enable")
      end
    end

    local function disable()
      if not disabled then
        disabled = true
        vim.cmd("Neominimap Disable")
      end
    end

    -- Is a normal file window open? (the tree, terminals and the minimap
    -- itself don't count)
    local function file_window_open()
      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "alpha" then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd({ "WinClosed", "WinEnter", "BufWinEnter", "BufWinLeave" }, {
      group = group,
      callback = function()
        vim.schedule(function()
          if file_window_open() then
            enable()
          else
            disable()
          end
        end)
      end,
    })

    -- The start screen sets its filetype only after its window exists, so the
    -- check above can't see it yet when it opens.
    vim.api.nvim_create_autocmd("User", {
      group = group,
      pattern = "AlphaReady",
      callback = disable,
    })
  end,
}
