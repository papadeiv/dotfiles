# Neovim config

A modular Neovim config for LaTeX, Julia, Python, C++ and GNU Octave, managed
with lazy.nvim.

## Layout

```
~/.config/nvim/
├── init.lua                  entry point: loads the four core modules
├── lua/core/
│   ├── options.lua           editor settings, leader key, .m files -> Octave
│   ├── keymaps.lua           global keybindings that don't need a plugin
│   ├── autocmds.lua          yank highlight, restore cursor position
│   └── lazy.lua              installs lazy.nvim, loads lua/plugins/*
├── lua/plugins/              one file per plugin (or small group of plugins)
│   ├── colorscheme.lua       catppuccin
│   ├── lualine.lua           status line (unchanged from the old config)
│   ├── devicons.lua          file icons (old icon overrides kept)
│   ├── neo-tree.lua          file navigator
│   ├── toggleterm.lua        terminals
│   ├── vimtex.lua            LaTeX compilation
│   ├── luasnip.lua           snippets
│   ├── autoclose.lua         bracket pairs
│   ├── completion.lua        autocomplete (blink.cmp)
│   ├── lsp.lua               language servers (Mason)
│   ├── formatting.lua        format on save (conform)
│   ├── treesitter.lua        syntax trees, code text objects
│   ├── minimap.lua           minimap
│   ├── claude.lua            Claude Code
│   ├── repl.lua              REPLs (iron.nvim)
│   ├── editing.lua           surround, flash
│   └── ui.lua                trouble, indent guides
├── lua/sources/octave.lua    Octave completion source
├── after/ftplugin/tex.lua    LaTeX-only keybindings
└── snippets/tex.lua          your LaTeX snippets (unchanged)
```

To add a plugin, create a file in `lua/plugins/` that returns a lazy.nvim spec.
To remove one, delete its file.

## Install

1. Install **Neovim 0.12+**, `git`, `curl`, `make`, a C compiler, `unzip`, and
   the **tree-sitter CLI** (0.26.1+, from your package manager, not npm).
2. Back up the old config: `mv ~/.config/nvim ~/.config/nvim.bak`
   (and optionally `~/.local/share/nvim`, which holds the old packer plugins).
3. Copy this folder to `~/.config/nvim` and start `nvim`. Plugins, language
   servers and treesitter parsers install on the first start; restart once
   it's done.

Also needed for specific features:

| Feature | Needs |
| --- | --- |
| LaTeX compile | a TeX distribution with `latexmk` and `xelatex` |
| Julia server + REPL | `julia` on your PATH |
| Python REPL | `python3` |
| Octave completion + REPL | `octave` on your PATH |
| Grammar checking (ltex) | nothing extra (Mason bundles Java) |
| Claude Code | the `claude` CLI, logged in |
| Icons, minimap | a Nerd Font; a font with Braille characters |

## Keybindings

`<leader>` is Space, `<localleader>` is `\`.

### Kept from the old config

| Keys | Mode | Action | File |
| --- | --- | --- | --- |
| `q` | n | new line below (like `o`) | core/keymaps.lua |
| `1` / `2` | n | start / end of line | core/keymaps.lua |
| `<leader>e` | n | toggle file navigator | plugins/neo-tree.lua |
| `<leader>w` | n | save (`:w!`) | core/keymaps.lua |
| `<leader>q` | n | quit without saving (`:q!`) | core/keymaps.lua |
| `<leader>h` | n | clear search highlight | core/keymaps.lua |
| `<leader>tf` / `th` / `tv` | n | floating / horizontal / vertical terminal | plugins/toggleterm.lua |
| `<Esc>` | t | leave terminal mode (not in Claude's terminal) | plugins/toggleterm.lua |
| `<Tab>` | i | expand snippet | plugins/luasnip.lua |
| `<S-Tab>` | i | next snippet placeholder | plugins/luasnip.lua |
| `<Tab>` | v | store selection for snippets | plugins/luasnip.lua |
| `<S-j>` / `<S-k>` | i | next / previous completion | plugins/completion.lua |
| `<S-i>` | i | accept completion | plugins/completion.lua |
| `<C-n>` `<C-p>` `<Up>` `<Down>` `<C-y>` `<C-e>` | i | completion menu | plugins/completion.lua |
| `dsm` / `csm` | n (tex) | delete / change math environment | after/ftplugin/tex.lua |
| `<localleader>v` | n (tex) | view PDF | after/ftplugin/tex.lua |
| vimtex defaults (`\ll`, `dse`, `cs$`, `ie`, ...) | | see `:help vimtex-default-mappings` | |

### New

| Keys | Mode | Action | File |
| --- | --- | --- | --- |
| `<leader>m` | n | record macro (replaces `q`) | core/keymaps.lua |
| `i` `a` `r` `d` | n (tree) | open / create / rename / delete | plugins/neo-tree.lua |
| `<leader>nm` | n | toggle minimap | plugins/minimap.lua |
| `<leader>nf` | n | move into / out of minimap | plugins/minimap.lua |
| `<leader>ic` `if` | n | Claude: toggle / focus | plugins/claude.lua |
| `<leader>ir` `iC` | n | Claude: resume / continue session | plugins/claude.lua |
| `<leader>im` `ib` | n | Claude: pick model / add file | plugins/claude.lua |
| `<leader>is` | v | Claude: send selection | plugins/claude.lua |
| `<leader>ia` `id` | n | Claude: accept / reject diff | plugins/claude.lua |
| `<leader>rr` `rR` | n | REPL: toggle / restart | plugins/repl.lua |
| `<leader>rl` `rp` `rf` `ru` | n | REPL: send line / paragraph / file / to cursor | plugins/repl.lua |
| `<leader>rc` | n, v | REPL: send motion / selection | plugins/repl.lua |
| `<leader>rb` `rn` | n | REPL: send cell / send and move on | plugins/repl.lua |
| `<leader>ro` `rh` `rq` `rx` `r<space>` | n | REPL: focus / hide / quit / clear / interrupt | plugins/repl.lua |
| `<leader>xx` `xb` `xq` | n | diagnostics (all / this file) / quickfix | plugins/ui.lua |
| `s` | n, v, o | flash jump | plugins/editing.lua |
| `ys` `ds` `cs` / `S` | n / v | surround | plugins/editing.lua |
| `af` `if` `ac` `ic` `aa` `ia` | v, o (code) | function / class / argument text objects | plugins/treesitter.lua |
| `]f` / `[f` | n (code) | next / previous function | plugins/treesitter.lua |

Language-server keys are Neovim's built-ins: `K` hover, `<C-]>` definition,
`grn` rename, `grr` references, `gra` code action, `gri` implementation,
`[d` / `]d` diagnostics.

## Notes

- `.m` files open as Octave. Octave completion suggests every function and
  keyword from your Octave install (cached on first use). Run
  `:OctaveRefreshCompletion` after installing Octave packages.
- The old `<leader>` bindings for Telescope, gitsigns, LSP, Packer, Alpha,
  lazygit etc. are not included, since they depended on plugins or
  functions that weren't installed.
- Useful commands: `:Lazy`, `:Mason`, `:ConformInfo`, `:checkhealth`.
