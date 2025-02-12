return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()

        local fzf = require("fzf-lua")

        -- Key mappings for fzf-lua
        vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>se", function()
            fzf.files({ cwd = vim.fn.getcwd() }) -- Similar to find_files with a custom command
        end, { desc = "[S]earch [E]xplorer" })
        vim.keymap.set("n", "<leader>sn", function()
            fzf.files({ cwd = "~/.config/nvim" })
        end, { desc = "[S]earch [N]eovim Config" })
        vim.keymap.set("n", "<leader>ss", fzf.builtin, { desc = "[S]earch [S]elect FzfLua" })
        vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
        vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sr", fzf.resume, { desc = "[S]earch [R]esume" })
        vim.keymap.set("n", "<leader>s.", fzf.oldfiles, { desc = "[S]earch Recent Files" })
        vim.keymap.set("n", "<leader>sb", fzf.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>gf", fzf.git_files, { desc = "[G]it [F]iles" })
        vim.keymap.set("n", "<leader>gb", fzf.git_branches, { desc = "[G]it [B]ranches" })
    end

}
