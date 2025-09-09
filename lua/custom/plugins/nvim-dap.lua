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

    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Set [b]reakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[c]ontinue' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[r]estart' })
    vim.keymap.set('n', '<F4>', dap.step_into, { desc = '[j] Step Into' })
    vim.keymap.set('n', '<F3>', dap.step_over, { desc = '[l] Step Over' })
    vim.keymap.set('n', '<F2>', dap.step_out, { desc = '[k] Step Out' })
    vim.keymap.set('n', '<F1>', dap.step_back, { desc = '[h] Step Back' })

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

    dap.adapters.cppdbg = require 'custom.dap.adapters.cppdbg'
    dap.configurations.c = require 'custom.dap.configurations.c'
    dap.configurations.cpp = require 'custom.dap.configurations.c'
    dap.configurations.rust = require 'custom.dap.configurations.c'

    dap.adapters.python = require 'custom.dap.adapters.python'
    dap.configurations.python = require 'custom.dap.configurations.python'
  end,
}
