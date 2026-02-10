-- See https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#python
return function(cb, config)
  if config.request == 'attach' then
    --@diagnostic disable-next-line: undefined-field
    local port = (config.connect or config).port
    --@diagnostic disable-next-line: undefined-field
    local host = (config.connect or config).host or '127.0.0.1'
    cb {
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    }
  else
    cb {
      type = 'executable',
      -- Expects `debugpy` to be installed in the virtual environment below.
      command = os.getenv 'HOME' .. '/.virtualenvs/debugpy/bin/python',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    }
  end
end
