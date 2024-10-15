return {
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("catppuccin-mocha")
			require("catppuccin").setup({
				integrations = {
					noice = true,
					diffview = true,
					notify = true,
					nvim_surround = true,
					lsp_trouble = true,
					dadbod_ui = true,
					which_key = true,
					mini = true,
				},
			})

			--  Translucent
			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalNc", { bg = "none" })
		end,
	},
}
