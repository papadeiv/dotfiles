require("toggleterm").setup{
        hide_numbers = true,
        insert_mappings = true,
        start_in_insert = true,
        auto_scroll = true,
        persist_size = true,
        --shell = '/home/papadeiv/.local/kitty.app/bin/kitty',
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
