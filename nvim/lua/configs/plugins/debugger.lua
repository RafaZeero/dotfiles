-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

-- return {
--   -- NOTE: Yes, you can install new plugins here!
--   "mfussenegger/nvim-dap",
--   -- NOTE: And you can specify dependencies as well
--   dependencies = {
--     -- Creates a beautiful debugger UI
--     "rcarriga/nvim-dap-ui",
--
--     -- Required dependency for nvim-dap-ui
--     "nvim-neotest/nvim-nio",
--
--     -- Installs the debug adapters for you
--     "williamboman/mason.nvim",
--     "jay-babu/mason-nvim-dap.nvim",
--
--     -- Add your own debuggers here
--     "leoluz/nvim-dap-go",
--     "mfussenegger/nvim-dap-python",
--   },
--   keys = function(_, keys)
--     local dap = require("dap")
--     local dapui = require("dapui")
--     return {
--       -- Basic debugging keymaps, feel free to change to your liking!
--       { "<F5>", dap.continue, desc = "Debug: Start/Continue" },
--       { "<F1>", dap.step_into, desc = "Debug: Step Into" },
--       { "<F2>", dap.step_over, desc = "Debug: Step Over" },
--       { "<F3>", dap.step_out, desc = "Debug: Step Out" },
--       { "<leader>b", dap.toggle_breakpoint, desc = "Debug: Toggle Breakpoint" },
--       {
--         "<leader>B",
--         function()
--           dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
--         end,
--         desc = "Debug: Set Breakpoint",
--       },
--       -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
--       { "<F7>", dapui.toggle, desc = "Debug: See last session result." },
--       unpack(keys),
--     }
--   end,
--   config = function()
--     local dap = require("dap")
--     local dapui = require("dapui")
--
--     require("mason-nvim-dap").setup({
--       -- Makes a best effort to setup the various debuggers with
--       -- reasonable debug configurations
--       automatic_installation = true,
--
--       -- You can provide additional configuration to the handlers,
--       -- see mason-nvim-dap README for more information
--       handlers = {},
--
--       -- You'll need to check that you have the required things installed
--       -- online, please don't ask me how to install them :)
--       ensure_installed = {
--         -- Update this to ensure that you have the debuggers for the langs you want
--         "delve",
--       },
--     })
--
--     -- Dap UI setup
--     -- For more information, see |:help nvim-dap-ui|
--     dapui.setup({
--       -- Set icons to characters that are more likely to work in every terminal.
--       --    Feel free to remove or use ones that you like more! :)
--       --    Don't feel like these are good choices.
--       icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
--       controls = {
--         icons = {
--           pause = "⏸",
--           play = "▶",
--           step_into = "⏎",
--           step_over = "⏭",
--           step_out = "⏮",
--           step_back = "b",
--           run_last = "▶▶",
--           terminate = "⏹",
--           disconnect = "⏏",
--         },
--       },
--     })
--
--     dap.listeners.after.event_initialized["dapui_config"] = dapui.open
--     dap.listeners.before.event_terminated["dapui_config"] = dapui.close
--     dap.listeners.before.event_exited["dapui_config"] = dapui.close
--
--     -- Install golang specific config
--     require("dap-go").setup({
--       delve = {
--         -- On Windows delve must be run attached or it crashes.
--         -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
--         detached = vim.fn.has("win32") == 0,
--       },
--     })
--   end,
-- }

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap-python",
      "microsoft/vscode-js-debug",
    },
    config = function()
      local dap = require("dap")
      local ui = require("dapui")

      require("dapui").setup()
      require("dap-go").setup()
      require("dap-python").setup("python3")

      require("nvim-dap-virtual-text").setup({
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      })

      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }

      -- local elixir_ls_debugger = vim.fn.exepath "elixir-ls-debugger"
      -- if elixir_ls_debugger ~= "" then
      --   dap.adapters.mix_task = {
      --     type = "executable",
      --     command = elixir_ls_debugger,
      --   }

      -- dap.configurations.elixir = {
      --   {
      --     type = "mix_task",
      --     name = "phoenix server",
      --     task = "phx.server",
      --     request = "launch",
      --     projectDir = "${workspaceFolder}",
      --     exitAfterTaskReturns = false,
      --     debugAutoInterpretAllModules = false,
      --   },
      -- }
      -- end

      local pythonPath = function()
        -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
        -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
          return cwd .. "/venv/bin/python"
        elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
          return cwd .. "/.venv/bin/python"
        else
          return "/usr/bin/python"
        end
      end

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = pythonPath(),
        },
        {
          type = "python",
          request = "attach",
          name = "Attach remote",
          connect = function()
            return {
              host = "127.0.0.1",
              port = 5678,
            }
          end,
        },
        {
          type = "python",
          request = "launch",
          name = "[Z] Django debugger",
          program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
          args = { "runserver", "--noreload" },
          -- justMyCode = true,
          -- django = true,
          -- console = "integratedTerminal",
        },
        {
          type = "debugpy",
          name = "[Z] Langgraph",
          request = "launch",
          -- program = vim.fn.getcwd() .. "/.venv/bin/langgraph",
          program = vim.fn.exepath("uv"),
          justMyCode = false,
          -- python = vim.fn.getcwd() .. "/.venv/bin/python",
          args = { "run", "langgraph", "dev" },
        },
        {
          type = "python",
          request = "launch",
          name = "Launch file with arguments",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " +")
          end,
          console = "integratedTerminal",
          pythonPath = pythonPath(),
        },
      }

      dap.adapters.python = {
        type = "executable",
        command = pythonPath(),
        args = { "-m", "debugpy.adapter" },
      }

      for _, lang in ipairs({
        "typescript",
        "javascript",
        "typescriptreact",
        "javascriptreact",
      }) do
        dap.configurations[lang] = dap.configurations[lang] or {}
        table.insert(dap.configurations[lang], {
          type = "node",
          request = "launch",
          name = "Launch server",
          url = "http://localhost:3003",
          sourceMaps = true,
        })
      end

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>Dgb", dap.run_to_cursor, opts)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>D?", function()
        require("dapui").eval(nil, { enter = true })
      end, { desc = "Eval under cursor" })

      vim.keymap.set("n", "<leader>D1", dap.continue, { desc = "[D]ebugger Continue", unpack(opts) })
      vim.keymap.set("n", "<leader>D2", dap.step_into, { desc = "[D]ebugger Step Into", unpack(opts) })
      vim.keymap.set("n", "<leader>D3", dap.step_over, { desc = "[D]ebugger Step Over", unpack(opts) })
      vim.keymap.set("n", "<leader>D4", dap.step_out, { desc = "[D]ebugger Step Out", unpack(opts) })
      vim.keymap.set("n", "<leader>D5", dap.step_back, { desc = "[D]ebugger Step Back", unpack(opts) })
      vim.keymap.set("n", "<leader>Dr", dap.restart, { desc = "[D]ebugger Restart", unpack(opts) })

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end
    end,
  },
}
