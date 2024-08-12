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
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "omnisharp",
                "jsonls"
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,


                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup{
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                jsonls = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.jsonls.setup {
                        capabilities = capabilities,
                    }
                end,
                omnisharp = function ()
                    local lspconfig = require("lspconfig")
                    lspconfig.omnisharp.setup {
                        capabilities = capabilities,
                    }
                end,

            }
        })

        -- COMPLETION STUFF
        local cmp_select = { behavior = cmp.SelectBehavior.Insert }
        cmp.setup({
            -- Enable luasnip to handle snippet expansion for nvim-cmp
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }, {"i", "s"}),

            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
                { name = 'path' },
                { name = 'buffer' },
                })
        })


        local ls = require("luasnip")
        ls.config.set_config {
            history = false,
            updateevents = "TextChanged, TextChangedI",
        }
        vim.keymap.set({"i", "s"}, "<C-k>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jumpable()
            end
        end, {silent = true })

        vim.keymap.set({"i", "s"}, "<C-j>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, {silent = true })

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
    end
}
