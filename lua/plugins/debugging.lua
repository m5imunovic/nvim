return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio"
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")

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
    vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "<leader>dc", dap.continue, {})

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      command = "/home/swexcad/.vscode/extensions/ms-vscode.cpptools-1.19.8-linux-x64/debugAdapters/bin/OpenDebugAD7",
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }


--    dap.adapters.lldb = {
--        type = "executable",
--        command = "/usr/bin/lldb-vscode-10",
--        name = "lldb"
--    }
--    dap.configurations.cpp = {
--      {
--        name = 'Launch',
--        type = 'lldb',
--        request = 'launch',
--        program = function()
--          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--        end,
--        cwd = '${workspaceFolder}',
--        stopOnEntry = false,
--        args = {},
--
--        -- 💀
--        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--        --
--        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--        --
--        -- Otherwise you might get the following error:
--        --
--        --    Error on launch: Failed to attach to the target process
--        --
--        -- But you should be aware of the implications:
--        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--        runInTerminal = false,
--      },
--    }
  end
}

