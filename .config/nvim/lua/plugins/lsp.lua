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
        -- Lsp extras
        -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("fidget").setup({})
        require("mason").setup({
            ensure_installed = { "csharpier", "netcoredb", "js-debug-adapter", "delve", "eslint_d", "prettierd", "rustywind" },
        })
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "denols",
                "angularls",
                "jsonls",
                "texlab",
                "sqlls",
                "cssls",
                "html",
                "emmet_language_server",
                "gopls",
                "rust_analyzer",
                "tailwindcss"
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

        lspconfig.gopls.setup({
            capabilities = capabilities,
        })

        lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
        })

        lspconfig.lua_ls.setup({
            capabilities = capabilities,
        })

        lspconfig.ts_ls.setup({
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern("package.json"),
            single_file_support = false
        })

        lspconfig.denols.setup({
            capabalities = capabilities,
            root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
        })

        lspconfig.angularls.setup({
            capabilities = capabilities,
        })

        lspconfig.texlab.setup({
            capabilities = capabilities,
        })

        lspconfig.tailwindcss.setup({
            capabilities = capabilities,
        })

        lspconfig.sqlls.setup({
            capabilities = capabilities,
        })

        lspconfig.jsonls.setup({
            settings = {
                json = {
                    schemas = require('schemastore').json.schemas(),
                    validate = { enable = true }
                }
            },
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
        -- local cmp_select = { behavior = cmp.SelectBehavior.Insert }
        -- cmp.setup({
        --     -- Enable luasnip to handle snippet expansion for nvim-cmp
        --     snippet = {
        --         expand = function(args)
        --             require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
        --         end,
        --     },
        --     window = {
        --         completion = cmp.config.window.bordered(),
        --         documentation = cmp.config.window.bordered(),
        --     },
        --     mapping = cmp.mapping.preset.insert({
        --         ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        --         ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        --         ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        --         ["<C-Space>"] = cmp.mapping.complete(),
        --     }, { "i", "s" }),
        --
        --     sources = cmp.config.sources({
        --         { name = "nvim_lsp" },
        --         { name = "luasnip" }, -- For luasnip users.
        --         { name = "path" },
        --         { name = "buffer" },
        --         { name = "terminal" },
        --     }),
        -- })

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

        -- local ls = require("luasnip")
        -- ls.config.set_config({
        --     history = false,
        --     updateevents = "TextChanged, TextChangedI",
        -- })
        --
        -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
        --     if ls.expand_or_jumpable() then
        --         ls.expand_or_jump()
        --     end
        -- end, { desc = "Expand or jump forward", silent = true })
        --
        -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
        --     if ls.jumpable(-1) then
        --         ls.jump(-1)
        --     end
        -- end, { desc = "Jump backward", silent = true })


        -- DIAGNOSTICS STUFF
        -- require("lsp_lines").setup()
        -- vim.keymap.set("", "<leader>l", require("lsp_lines").toggle, { desc = "Toggle lsp_lines" })
        -- vim.diagnostic.config({
        --     update_in_insert = true,
        --     float = {
        --         focusable = false,
        --         style = "minimal",
        --         border = "rounded",
        --         header = "",
        --         prefix = "",
        --     },
        --     virtual_text = false,
        --     virtual_lines = { only_current_line = true },
        -- })

        -- FORMATTING STUFF
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                cs = { "csharpier" },
                ts = { "prettierd" },
                tsx = { "prettierd" },
                rs = { "rustfmt" },
                css = { "prettierd", "prettier" },
                graphql = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                javascript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                markdown = { "prettierd", "prettier" },
                python = { "isort", "black" },
                sql = { "sql-formatter" },
                svelte = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier", "sql-formatter" },
                typescriptreact = { "prettierd", "prettier" },
                yaml = { "prettierd" },
            },
        })
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
