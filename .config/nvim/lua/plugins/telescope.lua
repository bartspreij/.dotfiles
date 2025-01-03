-- return {
--     "nvim-telescope/telescope.nvim",
--     tag = "0.1.8",
--     dependencies = {
--         {
--             "nvim-telescope/telescope-fzf-native.nvim",
--             build = "make"
--         },
--     },
--
--     config = function()
--         local actions = require("telescope.actions")
--         require("telescope").setup({
--             file_ignore_patterns = { "node_modules", ".git" },
--             defaults = {
--                 path_display = {
--                     "truncate",
--
--                 },
--                 mappings = {
--                     i = {
--                         ["<esc>"] = actions.close
--                     },
--                 },
--             },
--         })
--         require("telescope").load_extension("fzf")
--
--         local builtin = require("telescope.builtin")
--         vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
--         vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
--         vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
--         vim.keymap.set("n", "<leader>se", function()
--             builtin.find_files({ find_command = { "fd", "-t", "d" } })
--         end, { desc = "[S]earch [E]xplorer" })
--         vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
--         vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
--         vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
--         vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
--         vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
--         vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
--         vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[ ] Find existing buffers" })
--         vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "[G]it [F]iles" })
--         vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "[G]it [B]ranches" })
--
--         -- Shortcut for searching your Neovim configuration files
--         vim.keymap.set("n", "<leader>sn", function()
--             builtin.find_files({ cwd = vim.fn.stdpath("config") })
--         end, { desc = "[S]earch [N]eovim files" })
--
--         -- vim.keymap.set("n", "<leader>sp", '<cmd>Telescope luasnip<CR>', { desc = "[S]earch sni[p]pets" });
--     end,
-- }
