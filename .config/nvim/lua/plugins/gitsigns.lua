return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup()
		vim.keymap.set("n", "<leader>gh", ":Gitsigns preview_hunk<CR>", { desc = "[G]itsigns Preview [H]unk" })
		vim.keymap.set(
			"n",
			"<leader>gt",
			":Gitsigns toggle_current_line_blame<CR>",
			{ desc = "[G]itsigns [T]oggle Current Line Blame" }
		)
	end,
}
