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
					diffview = true,
					nvim_surround = true,
					lsp_trouble = true,
					dadbod_ui = true,
					which_key = true,
				},
			})

		end,
	},
}
