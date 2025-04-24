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
  use 'lervag/vimtex'  
    --NvimTree
  use 'nvim-tree/nvim-tree.lua'
  -- NvimTree dependency
  use 'nvim-tree/nvim-web-devicons'
  -- Whichkey
  use 'folke/which-key.nvim'
  -- Catppuccin color theme
  use { "catppuccin/nvim", as = "catppuccin" }
  -- Nord color theme
  use 'shaunsingh/nord.nvim'
  -- Onedark color theme
  use 'navarasu/onedark.nvim'
  -- Kanagawa color theme
  use 'rebelot/kanagawa.nvim'
  -- LuaLine
  use 'nvim-lualine/lualine.nvim'
  -- LuaSnip
  use({"L3MON4D3/LuaSnip",
	      -- follow latest release.
	      tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	      -- install jsregexp (optional!:).
	      run = "make install_jsregexp"
  })
  -- Autoclose
  use 'm4xshen/autoclose.nvim'
  -- ToogleTerm
  use 'akinsho/toggleterm.nvim'
  -- Nvim-Cmp
  use 'hrsh7th/nvim-cmp'
  -- Zotcite
  use 'jalvesaq/zotcite'
  -- Cmp-Zotcite
  use 'jalvesaq/cmp-zotcite'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end
)
