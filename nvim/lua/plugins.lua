local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  
  -- Packer
  use 'wbthomason/packer.nvim'
  -- VimTex
  use ({'lervag/vimtex', tag = "v2.15"})  
  -- NvimTree
  use 'nvim-tree/nvim-tree.lua'
  -- webdev icons (required by dependency)
  use 'nvim-tree/nvim-web-devicons'
  -- Whichkey
  use 'folke/which-key.nvim'
  -- Catppuccin color theme
  use { "catppuccin/nvim", as = "catppuccin" }
  -- LuaLine
  use 'nvim-lualine/lualine.nvim'
  -- Nvim-Cmp (completion engine) 
  use 'hrsh7th/nvim-cmp'
  -- LuaSnip (snippet engine, required by nvim-cmp)
  use({"L3MON4D3/LuaSnip", tag = "v2.*", run = "make install_jsregexp"})
  -- Cmp-luasnip (completion source, required by nvim-cmp)
  use 'saadparwaiz1/cmp_luasnip'
  -- Friendly snippets (snippets sources, required by nvim-cmp)
  use 'rafamadriz/friendly-snippets'
  -- cmp-nvim-lsp (nvim-cmp source, required by nvim-cmp)
  use 'hrsh7th/cmp-nvim-lsp'
  -- Autoclose
  use 'm4xshen/autoclose.nvim'
  -- ToogleTerm
  use 'akinsho/toggleterm.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end
)
