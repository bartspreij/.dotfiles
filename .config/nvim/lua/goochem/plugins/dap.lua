return {
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "mxsdev/nvim-dap-vscode-js",
        "nvim-neotest/nvim-nio",
    },
    keys = {
        -- normal mode is default
        { "<leader>b", function() require 'dap'.toggle_breakpoint() end },
        { "F5", function() require 'dap'.continue() end },
        { "F6",     function() require 'dap'.step_over() end },
        { "F7",     function() require 'dap'.step_into() end },
        { "F*",     function() require 'dap'.step_out() end },
    },
    config = function()
        require('dap-vscode-js').setup({
            debugger_path = vim.fn.stdpath('data') .. '/mason/packages/js-debug-adapter',
            debugger_cmd = { 'js-debug-adapter' },
            adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
        })

        local dap, dapui = require('dap'), require("dapui")
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({ reset = true })
        end
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close


        -- custom adapter for running tasks before starting debug
        local custom_adapter = 'pwa-node-custom'
        dap.adapters[custom_adapter] = function(cb, config)
            if config.preLaunchTask then
                local async = require('plenary.async')
                local notify = require('notify').async

                async.run(function()
                    ---@diagnostic disable-next-line: missing-parameter
                    notify('Running [' .. config.preLaunchTask .. ']').events.close()
                end, function()
                    vim.fn.system(config.preLaunchTask)
                    config.type = 'pwa-node'
                    dap.run(config)
                end)
            end
        end

        -- language config
        for _, language in ipairs({ 'typescript', 'javascript' }) do
            dap.configurations[language] = {
                {
                    name = 'Launch',
                    type = 'pwa-node',
                    request = 'launch',
                    program = '${file}',
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    sourceMaps = true,
                    skipFiles = { '<node_internals>/**' },
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
                {
                    name = 'Attach to node process',
                    type = 'pwa-node',
                    request = 'attach',
                    rootPath = '${workspaceFolder}',
                    processId = require('dap.utils').pick_process,
                },
                {
                    name = 'Debug Main Process (Electron)',
                    type = 'pwa-node',
                    request = 'launch',
                    program = '${workspaceFolder}/node_modules/.bin/electron',
                    args = {
                        '${workspaceFolder}/dist/index.js',
                    },
                    outFiles = {
                        '${workspaceFolder}/dist/*.js',
                    },
                    resolveSourceMapLocations = {
                        '${workspaceFolder}/dist/**/*.js',
                        '${workspaceFolder}/dist/*.js',
                    },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    sourceMaps = true,
                    skipFiles = { '<node_internals>/**' },
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
                {
                    name = 'Compile & Debug Main Process (Electron)',
                    type = custom_adapter,
                    request = 'launch',
                    preLaunchTask = 'npm run build-ts',
                    program = '${workspaceFolder}/node_modules/.bin/electron',
                    args = {
                        '${workspaceFolder}/dist/index.js',
                    },
                    outFiles = {
                        '${workspaceFolder}/dist/*.js',
                    },
                    resolveSourceMapLocations = {
                        '${workspaceFolder}/dist/**/*.js',
                        '${workspaceFolder}/dist/*.js',
                    },
                    rootPath = '${workspaceFolder}',
                    cwd = '${workspaceFolder}',
                    sourceMaps = true,
                    skipFiles = { '<node_internals>/**' },
                    protocol = 'inspector',
                    console = 'integratedTerminal',
                },
            }
        end

        require("dapui").setup()
    end
}
