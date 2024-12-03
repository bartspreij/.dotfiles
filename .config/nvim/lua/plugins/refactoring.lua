return { -- refactoring utilities
		"ThePrimeagen/refactoring.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = { show_success_message = true },
		keys = {
			-- stylua: ignore start
			{ "<leader>fi", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "x" }, desc = "󱗘 Inline Var" },
			{ "<leader>fe", function() require("refactoring").refactor("Extract Variable") end, mode = "x", desc = "󱗘 Extract Var" },
			{ "<leader>fu", function() require("refactoring").refactor("Extract Function") end, mode = "x", desc = "󱗘 Extract Func" },
			{ "<leader>fU", function() require("refactoring").refactor("Extract Function To File") end, mode = "x", desc = "󱗘 Extract Func to File" },
			-- stylua: ignore end
		},
	}
