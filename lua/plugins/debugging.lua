return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mfussenegger/nvim-dap-python",
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")
    dapui.setup()

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
    -- vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, {})
    -- vim.keymap.set("n", "<leader>dc", dap.continue, {})
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    -- vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    -- vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)

    dap.adapters.cppdbg = {
      id = "cppdbg",
      type = "executable",
      -- install cpptools via Mason
      command = vim.fn.expand("~/.local/share/nvim/mason/bin/OpenDebugAD7"),
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}/build',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
      },
    }

    dap.adapters.python = function(cb, config)
        cb({
            type = "executable",
            -- command = vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"),
            command =  os.getenv("CONDA_PREFIX") .. "/bin/python3",
            args = { "-m", "debugpy.adapter" },
            options = {
                source_filetype = "python",
            }
        })
    end

    dap.configurations.python = {
      {
        name = "Debug in menv";
        type = "python";
        request = "launch";
        program = "${file}";
        pythonPath = function()
            return os.getenv("CONDA_PREFIX") .. "/bin/python3"
            -- return vim.fn.expand("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3")
        end;
      }
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

