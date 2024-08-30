return {
	"christoomey/vim-tmux-navigator",
	config = function()
		vim.g.tmux_navigator_no_mappings = 0
		vim.keymap.set("n", "<C-w>h", ":TmuxNavigateLeft<CR>")
		vim.keymap.set("n", "<C-w>j", ":TmuxNavigateDown<CR>")
		vim.keymap.set("n", "<C-w>k", ":TmuxNavigateUp<CR>")
		vim.keymap.set("n", "<C-w>l", ":TmuxNavigateRight<CR>")
	end,
}
