return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
      "mfussenegger/nvim-dap-python",
      "microsoft/vscode-js-debug",
    },
    config = function()
      local dap = require("dap")
      dap.set_log_level("TRACE")
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

      local pythonPath = function()
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
          name = "[Z] Django debugger",
          program = vim.fn.getcwd() .. "/manage.py", -- NOTE: Adapt path to manage.py as needed
          args = { "runserver", "--noreload" },
        },
        {
          type = "debugpy",
          name = "[Z] Langgraph",
          request = "launch",
          -- program = vim.fn.getcwd() .. "/.venv/bin/langgraph",
          program = vim.fn.exepath("poe"),
          justMyCode = false,
          -- python = vim.fn.getcwd() .. "/.venv/bin/python",
          args = { "dev" },
        },
      }

      -- dap.configurations.go = {
      --   {
      --     type = "go",
      --     name = "[Z] Debug main.go (Gin)",
      --     request = "launch",
      --     program = "${workspaceFolder}/cmd/main.go", -- ou o caminho pro seu main real
      --     args = {},
      --     cwd = "${workspaceFolder}",
      --     stopOnEntry = false,
      --     showLog = true,
      --     dlvToolPath = vim.fn.exepath("dlv"), -- Reusando seu código
      --   },
      --   {
      --     type = "go",
      --     name = "[Z] Debug Current Package",
      --     request = "launch",
      --     program = "${fileDirname}",
      --     dlvToolPath = vim.fn.exepath("dlv"),
      --   },
      -- }

      dap.adapters.python = {
        type = "executable",
        command = pythonPath(),
        args = { "-m", "debugpy.adapter" },
      }

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>Db", dap.toggle_breakpoint, { desc = "Toggle [B]reakpoint" })
      vim.keymap.set("n", "<leader>Dgb", dap.run_to_cursor, opts)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>D?", function()
        ui.eval(nil, { enter = true })
      end, { desc = "Eval under cursor" })

      vim.keymap.set("n", "<F1>", dap.continue, { desc = "[D]ebugger Continue", unpack(opts) })
      vim.keymap.set("n", "<F2>", dap.step_into, { desc = "[D]ebugger Step Into", unpack(opts) })
      vim.keymap.set("n", "<F3>", dap.step_over, { desc = "[D]ebugger Step Over", unpack(opts) })
      vim.keymap.set("n", "<F4>", dap.step_out, { desc = "[D]ebugger Step Out", unpack(opts) })
      vim.keymap.set("n", "<F5>", dap.step_back, { desc = "[D]ebugger Step Back", unpack(opts) })

      vim.keymap.set("n", "<F6>", dap.restart, { desc = "[D]ebugger Restart", unpack(opts) })
      vim.keymap.set("n", "<leader>DB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "[D]ebugger [B]reakpoint condition", unpack(opts) })

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
