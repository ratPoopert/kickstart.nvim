return {
  {
    name = 'Launch',
    type = 'cppdbg',
    request = 'launch',
    program = function()
      local input = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      if input == vim.fn.getcwd() .. '/' then
        return vim.fn.input('Path to executable (~/.local/bin): ', '~/.local/bin' .. '/', 'file')
      else
        return input
      end
    end,
    args = {}, -- provide arguments if needed
    cwd = '${workspaceFolder}',
    stopAtBeginningOfMainSubprogram = false,
  },
  {
    name = 'Select and attach to process',
    type = 'cppdbg',
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
    type = 'cppdbg',
    request = 'launch',
    MIMode = 'gdb',
    miDebuggerServerAddress = 'localhost:1234',
    miDebuggerPath = '/usr/bin/gdb',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
  },
}
