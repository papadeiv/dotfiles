-- ============================================================================
-- plugins/dashboard.lua: start screen
-- ============================================================================
-- https://github.com/goolord/alpha-nvim
-- Shown when Neovim starts without a file. A neon city and logo in the
-- cyberdream colours, a few shortcuts, and the startup time.
--
-- To change the picture: edit `art`, and keep `colors` lined up with it
-- character by character. Each letter in `colors` picks a colour:
--   P purple   Y yellow   B blue   G grey   M magenta   (space = no colour)
-- The NEOVIM logo is coloured by a rule instead (solid blocks purple, outline
-- blue), so it has no colour lines.

local art = {
  "                 ╻                     ╻              ",
  "           ▗▄▖   ┃        ═╦═          ┃    ▗▄▄▖      ",
  "   ▗▖      ▐▪▌  ▐█▌   ▗▄▄▖ ║  ▗▄▖     ▐█▌   ▐▪▪▌  ▗▖  ",
  "   ▐▌ ▗▄▖  ▐▪▌  ▐▪▌   ▐▪▪▌▐█▌ ▐▪▌ ▗▄▖ ▐▪▌   ▐▪▪▌  ▐▌  ",
  " ▗▄▐▌ ▐▪▌▗▄▐▪▌▗▄▐▪▌▗▄▄▐▪▪▌▐▪▌▄▐▪▌▗▐▪▌▄▐▪▌▗▄▄▐▪▪▌▗▄▐▌▄ ",
  "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀",
}

local colors = {
  "                 B                     P              ",
  "           GGG   B        MMM          P    GGGG      ",
  "   BB      GYG  GGG   GGGG M  GGG     GGG   GYYG  PP  ",
  "   BB GGG  GYG  GYG   GYYGGGG GYG GGG GYG   GYYG  PP  ",
  " GGBB GYGGGGYGGGGYGGGGGYYGGYGGGYGGGYGGGYGGGGGYYGGGPPG ",
  "PPPPPPPPPPPPPPPPPPBBBBBBBBBBBBBBBBBBBBPPPPPPPPPPPPPPPPPP",
}

local logo = {
  "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗  ",
  "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║  ",
  "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║  ",
  "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║  ",
  "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║  ",
  "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝  ",
}

local tagline = "▸▸ THERE · IS · NO · SPOON ◂◂"

-- Colours: taken from cyberdream's palette (with the same values as a fallback)
local function set_highlights()
  local ok, palette = pcall(function() return require("cyberdream.colors").default end)
  local c = ok and palette or {
    purple = "#bd5eff", yellow = "#f1ff5e", blue = "#5ea1ff", grey = "#7b8496", magenta = "#ff5ef1",
  }
  vim.api.nvim_set_hl(0, "DashboardP", { fg = c.purple })
  vim.api.nvim_set_hl(0, "DashboardY", { fg = c.yellow })
  vim.api.nvim_set_hl(0, "DashboardB", { fg = c.blue })
  vim.api.nvim_set_hl(0, "DashboardG", { fg = c.grey })
  vim.api.nvim_set_hl(0, "DashboardM", { fg = c.magenta })
end

-- Turn a line of colour letters into alpha's highlight format
-- ({group, start_byte, end_byte} per character; art characters can be several bytes)
local function line_highlights(text, letters)
  local hl, byte = {}, 0
  local chars = vim.fn.split(text, "\\zs")
  for i, char in ipairs(chars) do
    local letter = letters:sub(i, i)
    if letter ~= "" and letter ~= " " then
      table.insert(hl, { "Dashboard" .. letter, byte, byte + #char })
    end
    byte = byte + #char
  end
  return hl
end

local function logo_colors(line)
  local letters = {}
  for _, char in ipairs(vim.fn.split(line, "\\zs")) do
    letters[#letters + 1] = (char == "█") and "P" or (char == " " and " " or "B")
  end
  return table.concat(letters)
end

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false, -- must load at startup to show the start screen

  config = function()
    set_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

    local dashboard = require("alpha.themes.dashboard")

    -- Header: city, blank line, logo, blank line, tagline
    local lines, hls = {}, {}
    local function add(text, letters)
      table.insert(lines, text)
      table.insert(hls, line_highlights(text, letters))
    end
    for i, text in ipairs(art) do add(text, colors[i]) end
    add(" ", " ")
    for _, text in ipairs(logo) do add(text, logo_colors(text)) end
    add(" ", " ")
    -- centre the tagline under the logo
    local pad = string.rep(" ", math.floor((vim.fn.strchars(logo[1]) - vim.fn.strchars(tagline)) / 2))
    add(pad .. tagline, pad .. string.rep("Y", vim.fn.strchars(tagline)))

    dashboard.section.header.val = lines
    dashboard.section.header.opts.hl = hls

    -- Shortcuts (press the key on the start screen)
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", "<cmd>enew<cr>"),
      dashboard.button("e", "  File tree", "<cmd>Neotree focus<cr>"),
      dashboard.button("l", "󰒲  Plugins", "<cmd>Lazy<cr>"),
      dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
    }
    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "DashboardB"
      button.opts.hl_shortcut = "DashboardP"
    end

    -- Footer: startup time, filled in once lazy.nvim has finished
    dashboard.section.footer.opts.hl = "DashboardG"
    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      once = true,
      callback = function()
        local stats = require("lazy").stats()
        dashboard.section.footer.val =
          string.format("%d plugins loaded in %.0f ms", stats.loaded, stats.startuptime)
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    require("alpha").setup(dashboard.config)
  end,
}
