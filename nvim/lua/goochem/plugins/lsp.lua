return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		-- Autoformatting
		"stevearc/conform.nvim",
	},
	config = function()
		require("fidget").setup({})
		require("mason").setup({
			ensure_installed = { "csharpier", "netcoredb" },
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"omnisharp",
				"jsonls",
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

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			filetypes = { "json" },
		})

		lspconfig.omnisharp.setup({
			handlers = {
				["textDocument/definition"] = function(...)
					return require("omnisharp_extended").handler(...)
				end,
			},
			keys = {
				{
					"gd",
					function()
						require("omnisharp_extended").telescope_lsp_definitions()
					end,
					desc = "Goto Definition",
				},
				{
					"gr",
					function()
						require("omnisharp_extended").telescope_lsp_references()
					end,
					desc = "Goto Implementation",
				},
				{
					"gi",
					function()
						require("omnisharp_extended").telescope_lsp_implementations()
					end,
					desc = "Goto Definition",
				},
			},
			capabilities = capabilities,
			enable_roslyn_analysers = true,
			enable_import_completion = true,
			organize_imports_on_format = true,
			enable_decompilation_support = true,
			filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "targets" },
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

		-- Set up vim-dadbod
		cmp.setup.filetype("sql", {
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
		})
		-- FORMATTING STUFF
		-- Autoformatting Setup
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "csharpier" },
				js = { "prettier" },
				json = { "prettier" },
			},
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				require("conform").format({
					bufnr = args.buf,
					lsp_fallback = true,
					quiet = true,
				})
			end,
		})
	end,
}
