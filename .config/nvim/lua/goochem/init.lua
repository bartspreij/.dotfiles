require("goochem.set")
require("goochem.remap")
require("goochem.config.lazy")

if vim.g.vscode then
	local vscode = require("vscode")
	-- VSCode-specific keybindings
	vim.keymap.set("n", "<leader>sh", function()
		vscode.action("workbench.action.showCommands")
	end, { noremap = true, silent = true, desc = "[S]how [H]elp / Command Palette" })

	vim.keymap.set("n", "<leader>sf", function()
		vscode.action("workbench.action.quickOpen")
	end, { noremap = true, silent = true, desc = "[S]earch [F]iles" })
end

local augroup = vim.api.nvim_create_augroup
local ThePrimeagenGroup = augroup("ThePrimeagen", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

-- removes trailing whitespace
autocmd({ "BufWritePre" }, {
	group = ThePrimeagenGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = ThePrimeagenGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "gD", function()
			vim.lsp.buf.declaration()
		end, opts)
		vim.keymap.set("n", "gi", function()
			vim.lsp.buf.implementation()
		end, opts)
		vim.keymap.set("n", "gr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "gO", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("n", "<leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Toggle inlay hints" })
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts)

		require("lsp_signature").on_attach({}, opts.buffer)
	end,
})

autocmd({ "BufEnter", "InsertLeave" }, {
	group = ThePrimeagenGroup,
	pattern = "*.cs",
	callback = function()
		vim.lsp.codelens.refresh()
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
