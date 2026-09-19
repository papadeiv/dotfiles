-- ============================================================================
-- plugins/dashboard.lua: start screen
-- ============================================================================
-- https://github.com/goolord/alpha-nvim
-- Shown when Neovim starts without a file: a neon city and logo in the
-- cyberdream colours, two shortcuts (e = file tree, l = plugins) and a
-- quote-of-the-day cow beside a boxed summary of the machine.
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

-- Colours: the active theme's own accents, from lua/theme.lua (not guessed
-- from generic syntax groups, which don't reliably line up with "yellow" or
-- "purple" between themes).
local function set_highlights()
  local c = require("theme").accents()
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

-- Quote of the day (fortune | cowsay) -----------------------------------------
-- Needs the two classic programs:
--   Arch:    sudo pacman -S cowsay fortune-mod
--   Ubuntu:  sudo apt install cowsay fortune-mod fortunes
-- Change the animal with the -f flag below (`cowsay -l` lists them all).

local cowsay_args = "-W 36" -- wrap the text at 36 columns; add e.g. -f tux

local function find_program(name)
  if vim.fn.executable(name) == 1 then
    return name
  end
  local path = "/usr/games/" .. name -- where Debian/Ubuntu put them
  if vim.fn.executable(path) == 1 then
    return path
  end
end

-- The output of `fortune -s | cowsay`, as a block of lines
local function cow_lines()
  local fortune, cowsay = find_program("fortune"), find_program("cowsay")
  if not (fortune and cowsay) then
    return { "( install cowsay and fortune for the quote of the day )" }, 1
  end

  local lines = vim.fn.systemlist(fortune .. " -s | " .. cowsay .. " " .. cowsay_args)
  if vim.v.shell_error ~= 0 or #lines == 0 then
    return { "( fortune | cowsay produced nothing )" }, 1
  end

  -- Where the speech bubble ends and the animal begins: the last line made
  -- only of dashes and spaces (cowsay's bottom border).
  local bubble_end = #lines
  for i, line in ipairs(lines) do
    if line:match("^[%s%-]+$") then
      bubble_end = i
    end
  end
  return lines, bubble_end
end

-- System info (neofetch style) -------------------------------------------------

local function read(path)
  local file = io.open(path, "r")
  if not file then
    return nil
  end
  local text = file:read("*a")
  file:close()
  return text
end

local function os_name()
  local text = read("/etc/os-release") or ""
  return text:match('PRETTY_NAME="([^"]+)"') or "Linux"
end

local function cpu_name()
  local text = read("/proc/cpuinfo") or ""
  local model = text:match("model name%s*:%s*([^\n]+)")
  if not model then
    return nil
  end
  local cores = select(2, text:gsub("processor%s*:", ""))
  model = model:gsub("%(R%)", ""):gsub("%(TM%)", ""):gsub("CPU ", ""):gsub("%s+@.*", ""):gsub("%s+", " ")
  return model .. " (" .. cores .. ")"
end

local function gpu_name()
  if vim.fn.executable("lspci") == 0 then
    return nil
  end
  for _, line in ipairs(vim.fn.systemlist("lspci")) do
    local name = line:match("VGA compatible controller: (.+)") or line:match("3D controller: (.+)")
    if name then
      return (name:gsub("%b[]", ""):gsub("%s+", " "))
    end
  end
end

local function memory()
  local text = read("/proc/meminfo") or ""
  local total = tonumber(text:match("MemTotal:%s*(%d+)"))
  local available = tonumber(text:match("MemAvailable:%s*(%d+)"))
  if not (total and available) then
    return nil
  end
  return string.format("%.1f / %.1f GiB", (total - available) / 1048576, total / 1048576)
end

local function desktop()
  local de = vim.env.XDG_CURRENT_DESKTOP or vim.env.DESKTOP_SESSION
  if not de or de == "" then
    return nil
  end
  local session = vim.env.XDG_SESSION_TYPE -- x11 or wayland
  return de .. (session and session ~= "" and (" (" .. session .. ")") or "")
end

-- The shell you use. For the terminal emulator instead, swap SHELL for
-- TERM_PROGRAM or TERM below.
local function shell()
  local path = vim.env.SHELL
  return path and path ~= "" and vim.fn.fnamemodify(path, ":t") or nil
end

-- The machine, in a rounded box with a HARDWARE and a SOFTWARE part.
-- Each entry is { icon, label, value }; entries with no value are skipped, so
-- a machine without lspci simply shows no GPU line. "" is a blank line and
-- { headline = "..." } a yellow heading. Add, remove or reorder rows freely.
local function system_info()
  local rows = {
    { headline = "HARDWARE" },
    { "", "CPU", cpu_name() },
    { "󰢮", "GPU", gpu_name() },
    { "", "RAM", memory() },
    "",
    { headline = "SOFTWARE" },
    { "", "OS", os_name() .. " " .. vim.uv.os_uname().machine },
    { "", "DE", desktop() },
    { "", "CLI", shell() },
  }

  -- Widest label, so the values line up
  local label_width = 0
  for _, row in ipairs(rows) do
    if type(row) == "table" and row[3] and row[3] ~= "" then
      label_width = math.max(label_width, #row[2])
    end
  end

  -- Build the contents of the box: text plus where the value starts
  local contents = {}
  for _, row in ipairs(rows) do
    if row == "" then
      table.insert(contents, { text = "" })
    elseif row.headline then
      table.insert(contents, { text = "  " .. row.headline, headline = true })
    elseif row[3] and row[3] ~= "" then
      local left = string.format("  %s  %-" .. label_width .. "s   ", row[1], row[2])
      table.insert(contents, { text = left .. row[3], value_at = #left })
    end
  end

  -- The box is as wide as its widest line (display width, not bytes)
  local width = 0
  for _, line in ipairs(contents) do
    width = math.max(width, vim.fn.strdisplaywidth(line.text))
  end

  local lines, highlights = {}, {}
  local function add(text, hl)
    table.insert(lines, text)
    table.insert(highlights, hl)
  end

  local top = "╭" .. string.rep("─", width + 2) .. "╮"
  local bottom = "╰" .. string.rep("─", width + 2) .. "╯"
  add(top, { { "DashboardB", 0, #top } })

  for _, line in ipairs(contents) do
    local padding = string.rep(" ", width - vim.fn.strdisplaywidth(line.text))
    local text = "│ " .. line.text .. padding .. " │"
    local left_border = #"│ " -- bytes before the content starts

    local hl = {
      { "DashboardB", 0, left_border },      -- left border
      { "DashboardB", #text - 4, #text },    -- right border
    }
    if line.headline then
      table.insert(hl, { "DashboardY", left_border, left_border + #line.text })
    elseif line.value_at then
      table.insert(hl, { "DashboardP", left_border, left_border + line.value_at })
      table.insert(hl, { "DashboardG", left_border + line.value_at, #text - 4 })
    end
    add(text, hl)
  end

  add(bottom, { { "DashboardB", 0, #bottom } })
  return lines, highlights
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

    -- Shortcuts: one row of text...
    local shortcuts = {
      type = "text",
      val = "  File tree  (e)      󰒲  Plugins  (l)",
      opts = { position = "center", hl = "DashboardB" },
    }

    -- ...and the keys that go with it, set in the start screen's own buffer
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function(args)
        vim.keymap.set("n", "e", "<cmd>Neotree focus<cr>", { buffer = args.buf, desc = "File tree" })
        vim.keymap.set("n", "l", "<cmd>Lazy<cr>", { buffer = args.buf, desc = "Plugins" })
      end,
    })

    -- Two columns: the cow and its quote on the left, the machine on the right
    local cow, cow_end = cow_lines()
    local info_lines, info_hls = system_info()

    local left_width = 0
    for _, line in ipairs(cow) do
      left_width = math.max(left_width, #line)
    end

    -- Put the shorter column in the middle of the taller one
    local rows = math.max(#cow, #info_lines)
    local cow_top = math.floor((rows - #cow) / 2)
    local info_top = math.floor((rows - #info_lines) / 2)

    local columns, column_hls = {}, {}
    local gap = "     "
    for row = 1, rows do
      local left = cow[row - cow_top] or ""
      local right_index = row - info_top
      local right = info_lines[right_index] or ""
      local padded = left .. string.rep(" ", left_width - #left) .. gap

      table.insert(columns, padded .. right)

      -- the bubble in yellow, the cow in purple, then the machine lines as they were
      local hl = { { (row - cow_top) > cow_end and "DashboardP" or "DashboardY", 0, #left } }
      for _, part in ipairs(info_hls[right_index] or {}) do
        table.insert(hl, { part[1], part[2] + #padded, part[3] + #padded })
      end
      table.insert(column_hls, hl)
    end

    local info = {
      type = "text",
      val = columns,
      opts = { position = "center", hl = column_hls },
    }

    -- Order of everything on the screen
    dashboard.config.layout = {
      { type = "padding", val = 2 },
      dashboard.section.header,
      { type = "padding", val = 2 },
      shortcuts,
      { type = "padding", val = 2 },
      info,
    }

    require("alpha").setup(dashboard.config)
  end,
}
