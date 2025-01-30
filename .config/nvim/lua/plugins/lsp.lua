return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "j-hui/fidget.nvim",
    -- Autoformatting
    "stevearc/conform.nvim",
  },
  config = function()
    require("fidget").setup({})
    require("mason").setup({
      ensure_installed = { "csharpier", "netcoredb", "js-debug-adapter", "delve", "eslint", "rustywind", "isort", "black" },
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
        "tailwindcss",
        "pyright",
        "phpactor",
      },
    })
    local lspconfig = require("lspconfig")
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    lspconfig.phpactor.setup({
      capabilities = capabilities,
    })

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

    -- FORMATTING STUFF
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
        ts = { "prettier" },
        tsx = { "prettier" },
        rs = { "rustfmt" },
        css = { "prettier", "prettier" },
        graphql = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        sql = { "sql-formatter" },
        svelte = { "prettier" },
        typescript = { "prettier", "sql-formatter" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
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
