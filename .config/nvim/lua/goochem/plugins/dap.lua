return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
		"nicholasmata/nvim-dap-cs",
	},
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		require("dapui").setup()
		require("dap-go").setup()
		require("dap-cs").setup()
		-- require("nvim-dap-virtual-text").setup()
		-- dap.adapters.coreclr = {
		--     type = 'executable',
		--     command = '/usr/local/bin/netcoredbg/netcoredbg',
		--     args = { '--interpreter=vscode' }
		-- }
		--
		-- dap.configurations.cs = {
		--     {
		--         type = "coreclr",
		--         name = "launch - netcoredbg",
		--         request = "launch",
		--         program = function()
		--             return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
		--         end,
		--         console = "intergratedTerminal"
		--     },
		-- }

		-- Neotest Test runner looks at this table
		dap.adapters.netcoredbg = vim.deepcopy(dap.adapters.coreclr)

		dapui.setup({
			controls = {
				element = "repl",
				enabled = true,
				icons = {
					disconnect = "",
					pause = "",
					play = "",
					run_last = "",
					step_back = "",
					step_into = "",
					step_out = "",
					step_over = "",
					terminate = "",
				},
			},
			element_mappings = {},
			expand_lines = true,
			floating = {
				border = "single",
				mappings = {
					close = { "q", "<Esc>" },
				},
			},
			force_buffers = true,
			icons = {
				collapsed = "",
				current_frame = "",
				expanded = "",
			},
			layouts = {
				{
					elements = {
						{
							id = "console",
							size = 0.2,
						},
						{
							id = "breakpoints",
							size = 0.2,
						},
						{
							id = "stacks",
							size = 0.2,
						},
						{
							id = "repl",
							size = 0.2,
						},
						{
							id = "watches",
							size = 0.2,
						},
					},
					position = "left",
					size = 50,
				},
				{
					elements = { {
						id = "scopes",
						size = 1,
					} },
					position = "bottom",
					size = 10,
				},
			},
			mappings = {
				edit = "e",
				expand = { "<CR>", "<2-LeftMouse>" },
				open = "o",
				remove = "d",
				repl = "r",
				toggle = "t",
			},
			render = {
				indent = 1,
				max_value_lines = 100,
			},
		})
		------------
		-- Dap UI --
		------------

		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

		-- KEYBINDS TODO: fix and decide keymap
		vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
		-- vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

		-- Eval var under cursor
		vim.keymap.set("n", "<space>?", function()
			require("dapui").eval(nil, { enter = true })
		end)

		vim.keymap.set("n", "<F1>", dap.continue)
		vim.keymap.set("n", "<F2>", dap.step_into)
		vim.keymap.set("n", "<F3>", dap.step_over)
		vim.keymap.set("n", "<F4>", dap.step_out)
		vim.keymap.set("n", "<F5>", dap.step_back)
		vim.keymap.set("n", "<F13>", dap.restart)
	end,
}
