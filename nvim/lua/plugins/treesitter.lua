-- ============================================================================
-- plugins/treesitter.lua: syntax trees for code
-- ============================================================================
-- https://github.com/nvim-treesitter/nvim-treesitter            (main branch)
-- https://github.com/nvim-treesitter/nvim-treesitter-textobjects (main branch)
--
-- Requires the `tree-sitter` CLI and a C compiler (parsers are compiled locally).
-- LaTeX is left to vimtex, which highlights it better.
--
-- Text objects (code files only; use with d, c, y, v...):
--   af / if  a function / inside a function
--   ac / ic  a class    / inside a class
--   aa / ia  an argument / inside an argument
-- Motions:  ]f / [f  next / previous function start

-- Parsers to install
local parsers = {
  "julia", "python", "cpp", "c", "matlab", "bash",
  "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "bibtex",
  "html", "yaml", -- used by render-markdown (HTML comments, front matter)
}

-- Filetypes that get treesitter highlighting and text objects
local code_filetypes = { "julia", "python", "cpp", "c", "octave", "lua", "bash", "sh", "markdown" }

-- Filetypes that also use treesitter for indentation (still experimental;
-- Python is better served by Neovim's own indent rules)
local ts_indent = { julia = true, cpp = true, c = true, octave = true }

local function textobject_keymaps(bufnr)
  local select = require("nvim-treesitter-textobjects.select")
  local move = require("nvim-treesitter-textobjects.move")

  local objects = {
    af = "@function.outer", ["if"] = "@function.inner",
    ac = "@class.outer",    ic = "@class.inner",
    aa = "@parameter.outer", ia = "@parameter.inner",
  }
  for lhs, query in pairs(objects) do
    vim.keymap.set({ "x", "o" }, lhs, function()
      select.select_textobject(query, "textobjects")
    end, { buffer = bufnr, desc = "Select " .. query })
  end

  vim.keymap.set({ "n", "x", "o" }, "]f", function()
    move.goto_next_start("@function.outer", "textobjects")
  end, { buffer = bufnr, desc = "Next function" })
  vim.keymap.set({ "n", "x", "o" }, "[f", function()
    move.goto_previous_start("@function.outer", "textobjects")
  end, { buffer = bufnr, desc = "Previous function" })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- does not support lazy-loading
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      -- Octave uses the MATLAB parser (the syntax is nearly identical)
      vim.treesitter.language.register("matlab", "octave")

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_setup", { clear = true }),
        pattern = code_filetypes,
        callback = function(args)
          -- pcall: skip quietly if the parser isn't installed yet
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          if ts_indent[args.match] then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
          textobject_keymaps(args.buf)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    lazy = false,
    opts = {
      select = { lookahead = true }, -- jump forward to the next match if not inside one
      move = { set_jumps = true },   -- ]f / [f can be undone with <C-o>
    },
  },
}
