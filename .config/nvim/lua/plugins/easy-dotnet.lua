local function add_dotnet_mappings()
  local dotnet = require("easy-dotnet")

  vim.api.nvim_create_user_command('Secrets', function()
    dotnet.secrets()
  end, {})

  vim.keymap.set("n", "<A-t>", function()
    vim.cmd("Dotnet testrunner")
  end, { desc = "Run .NET tests using Dotnet testrunner" })

  vim.keymap.set("n", "<C-p>", function()
    dotnet.run()
  end, { desc = "Run .NET project using dotnet run" })

  vim.keymap.set("n", "<C-b>", function()
    dotnet.build_default_quickfix()
  end, { desc = "Build .NET project and populate quickfix list" })

end

return {
  "GustavEikaas/easy-dotnet.nvim",
  dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
  config = function()
    local dotnet = require("easy-dotnet")
    dotnet.setup({
      test_runner = {
        enable_buffer_test_execution = false,
        viewmode = "float",
      },
      auto_bootstrap_namespace = false,
      terminal = function(path, action)
        local commands = {
          run = function()
            return "dotnet run" .. path
          end,
          test = function()
            return "dotnet test --logger '--logger:console;verbosity=normal' --verbosity quiet --nologo" .. path
          end,
          restore = function()
            return "dotnet restore " .. path
          end,
          build = function()
            return "dotnet build" .. path
          end
        }
        local command = commands[action]() .. "\r"
        require("toggleterm").exec(command, nil, nil, nil, "float")
      end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if dotnet.is_dotnet_project() then
          add_dotnet_mappings()
        end
      end,
    })
  end
}
