return {
    {
        "mfussenegger/nvim-dap",
        dependencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio" },
        config = function()
            local dap, dapui, dap_utils = require("dap"), require("dapui"), require("dap.utils")

            ---@diagnostic disable-next-line: missing-fields
            dapui.setup({
                mappings = {
                    edit = "i",
                    remove = "dd",
                },
            })

            local function keymap(mode, lhs, rhs, opts)
                opts.desc = string.format("Dap: %s", opts.desc)
                vim.keymap.set(mode, lhs, function()
                    rhs()
                    vim.fn["repeat#set"](vim.keycode(lhs))
                end, opts)
            end

            vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "Error", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "→", texthl = "Error", linehl = "DiffAdd", numhl = "" })

            keymap("n", "<leader>b", dap.toggle_breakpoint, { desc = "Add breakpoint" })
            keymap("n", "<leader>d<leader>", dap.continue, { desc = "Continue debugging" })
            keymap("n", "<leader>dl", dap.step_into, { desc = "Step into" })
            keymap("n", "<leader>dj", dap.step_over, { desc = "Step over" })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            dap.adapters.coreclr = {
                type = "executable",
                command = vim.fn.exepath("netcoredbg"),
                args = { "--interpreter=vscode" },
            }

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch",
                    request = "launch",
                    program = function()
                        local project_path = vim.fs.root(0, function(name)
                            return name:match("%.csproj$") ~= nil
                        end)

                        if not project_path then
                            return vim.notify("Couldn't find the csproj path")
                        end

                        return dap_utils.pick_file({
                            filter = string.format("Debug/.*/%s", vim.fn.fnamemodify(project_path, ":t:r")),
                            path = string.format("%s/bin", project_path),
                        })
                    end,
                },

                {
                    type = "coreclr",
                    name = "Attach",
                    request = "attach",
                    processId = dap_utils.pick_process,
                },

                {
                    type = "coreclr",
                    name = "Attach (Smart)",
                    request = "attach",
                    processId = function()
                        if not vim.g.roslyn_nvim_selected_solution then
                            return vim.notify("No solution file found")
                        end

                        local solution_dir = vim.fs.dirname(vim.g.roslyn_nvim_selected_solution)

                        local res = vim.system({ "dotnet", "sln", vim.g.roslyn_nvim_selected_solution, "list" }):wait()
                        local csproj_files = vim.iter(vim.split(res.stdout, "\n"))
                            :map(function(it)
                                local fullpath = vim.fs.normalize(vim.fs.joinpath(solution_dir, it))
                                if fullpath ~= solution_dir and vim.uv.fs_stat(fullpath) then
                                    return fullpath
                                else
                                    return nil
                                end
                            end)
                            :totable()

                        return dap_utils.pick_process({
                            filter = function(proc)
                                return vim.iter(csproj_files):find(function(file)
                                    if vim.endswith(proc.name, vim.fn.fnamemodify(file, ":t:r")) then
                                        return true
                                    end
                                end)
                            end,
                        })
                    end,
                },
            }
        end,
    },
}
