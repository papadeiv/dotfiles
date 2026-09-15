-- ============================================================================
-- sources/octave.lua: completion source for GNU Octave
-- ============================================================================
-- Octave has no mature language server, so this small blink.cmp source
-- suggests the names of every function and keyword in your Octave install.
--
-- The list is generated once by running Octave, then cached in:
--   ~/.cache/nvim/octave_functions.txt
-- Delete that file (or run :OctaveRefreshCompletion) after installing new
-- Octave packages to regenerate it.

local cache_file = vim.fn.stdpath("cache") .. "/octave_functions.txt"

-- Octave code that prints one name per line: all functions, then keywords
local octave_script = [[
names = __list_functions__();
printf("%s\n", names{:});
keywords = iskeyword();
printf("%s\n", keywords{:});
]]

local words = nil       -- the loaded list, or nil if not loaded yet
local generating = false

local function load_cache()
  if vim.uv.fs_stat(cache_file) then
    words = vim.fn.readfile(cache_file)
  end
end

local function generate_cache()
  if generating or vim.fn.executable("octave") == 0 then
    return
  end
  generating = true
  vim.system(
    { "octave", "--no-gui", "--no-window-system", "--norc", "--quiet", "--eval", octave_script },
    { text = true },
    function(result)
      generating = false
      if result.code == 0 then
        local lines = vim.split(result.stdout, "\n", { trimempty = true })
        vim.schedule(function()
          vim.fn.writefile(lines, cache_file)
          words = lines
        end)
      end
    end
  )
end

vim.api.nvim_create_user_command("OctaveRefreshCompletion", function()
  os.remove(cache_file)
  words = nil
  generate_cache()
end, { desc = "Regenerate the Octave function list used for completion" })

-- blink.cmp source interface -------------------------------------------------
local source = {}

function source.new()
  load_cache()
  if not words then
    generate_cache()
  end
  return setmetatable({}, { __index = source })
end

function source:get_completions(_, callback)
  local items = {}
  local kind = require("blink.cmp.types").CompletionItemKind.Function
  for _, name in ipairs(words or {}) do
    items[#items + 1] = { label = name, kind = kind }
  end
  callback({ items = items, is_incomplete_backward = false, is_incomplete_forward = false })
end

return source
