return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{
			"yioneko/nvim-cmp",
			branch = "perf",
		},
		{ "L3MON4D3/LuaSnip", dependencies = { "rafamadriz/friendly-snippets" } },
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		-- Autoformatting
		"stevearc/conform.nvim",
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()
		require("fidget").setup({})
		require("mason").setup({
			ensure_installed = { "csharpier", "netcoredb" },
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				-- "omnisharp",
				"ts_ls",
				"angularls",
				"jsonls",
				"texlab",
				"sqlls",
				"cssls",
				"html",
				"emmet_language_server",
			},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local lspconfig = require("lspconfig")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.ts_ls.setup({
			capabilities = capabilities,
		})

		lspconfig.angularls.setup({
			capabilities = capabilities,
		})

		lspconfig.texlab.setup({
			capabilities = capabilities,
		})

		lspconfig.sqlls.setup({
			capabilities = capabilities,
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			filetypes = { "json" },
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
		})

		lspconfig.html.setup({
			capabilities = capabilities,
		})

		lspconfig.emmet_language_server.setup({
			capabilities = capabilities,
		})

		-- COMPLETION STUFF
		local cmp_select = { behavior = cmp.SelectBehavior.Insert }
		cmp.setup({
			-- Enable luasnip to handle snippet expansion for nvim-cmp
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}, { "i", "s" }),

			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
				{ name = "path" },
				{ name = "buffer" },
				{ name = "terminal" },
			}),
		})

		-- autopairs
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

		-- Set up vim-dadbod
		cmp.setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			},
		})

		local ls = require("luasnip")
		ls.config.set_config({
			history = false,
			updateevents = "TextChanged, TextChangedI",
		})

		vim.keymap.set({ "i", "s" }, "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jumpable()
			end
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-j>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		-- DIAGNOSTICS STUFF
		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
			virtual_text = false,
			virtual_lines = { only_current_line = true },
			vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" }),
		})
		-- FORMATTING STUFF
		-- Autoformatting Setup
		-- require("conform").setup({
		-- 	formatters_by_ft = {
		-- 		lua = { "stylua" },
		-- 		cs = { "csharpier" },
		-- 		js = { "prettier" },
		-- 		ts = { "prettier" },
		-- 		json = { "prettier" },
		-- 		jsonc = { "prettier" },
		-- 		html = { "prettier" },
		-- 	},
		-- })
		--
		-- vim.api.nvim_create_autocmd("BufWritePre", {
		-- 	callback = function(args)
		-- 		require("conform").format({
		-- 			bufnr = args.buf,
		-- 			lsp_fallback = true,
		-- 			quiet = true,
		-- 		})
		-- 	end,
		-- })
	end,
}
