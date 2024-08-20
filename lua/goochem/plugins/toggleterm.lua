return {
    'akinsho/toggleterm.nvim',
    version = "*",
    cmd = "ToggleTerm",
    keys = {

        { '<C-\\>',  '<cmd>:1ToggleTerm direction=float<CR>',              mode = { 'n', 'i', 't' } },
        { '<M-1>',   '<cmd>:2ToggleTerm direction=horizontal size=20<CR>', mode = { 'n', 't' } },
        { '<M-2>',   '<cmd>:3ToggleTerm direction=vertical size=100<CR>',  mode = { 'n', 't' } },
        { '<M-F51>', '<cmd>:4ToggleTerm direction=float<CR>',              mode = { 'n', 't' } },
    },
    config = function()
        require('toggleterm').setup({
            start_in_insert = true,
            terminal_mappings = true,
            auto_scroll = true,
            persist_size = true,
            close_on_exit = true,
        })
    end
}
