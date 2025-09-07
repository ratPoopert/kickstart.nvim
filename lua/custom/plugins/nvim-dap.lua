return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'williamboman/mason.nvim',
  },
  config = function()
    -- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    local dap = require 'dap'

    vim.keymap.set('n', '<leader>d<space>', dap.toggle_breakpoint, { desc = '[ ] Set breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[c]ontinue' })
    vim.keymap.set('n', '<leader>dj', dap.step_into, { desc = '[j] Step Into' })
    vim.keymap.set('n', '<leader>dl', dap.step_over, { desc = '[l] Step Over' })
    vim.keymap.set('n', '<leader>dk', dap.step_out, { desc = '[k] Step Out' })
    vim.keymap.set('n', '<leader>dh', dap.step_back, { desc = '[h] Step Back' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[r]estart' })

    local ui = require 'dapui'
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

    dap.adapters.gdb = {
      type = 'executable',
      command = 'gdb',
      args = { '--interpreter=dap', '--eval-command', 'set print pretty on' },
    }

    dap.configurations.c = {
      {
        name = 'Launch',
        type = 'gdb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        args = {}, -- provide arguments if needed
        cwd = '${workspaceFolder}',
        stopAtBeginningOfMainSubprogram = false,
      },
      {
        name = 'Select and attach to process',
        type = 'gdb',
        request = 'attach',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        pid = function()
          local name = vim.fn.input 'Executable name (filter): '
          return require('dap.utils').pick_process { filter = name }
        end,
        cwd = '${workspaceFolder}',
      },
      {
        name = 'Attach to gdbserver :1234',
        type = 'gdb',
        request = 'attach',
        target = 'localhost:1234',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
      },
    }

    dap.configurations.cpp = dap.configurations.c
    dap.configurations.rust = dap.configurations.c
  end,
}
