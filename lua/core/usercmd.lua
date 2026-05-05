vim.api.nvim_create_user_command(
  "EditHere",
  function(command_args)
    local directory = vim.fn.expand("%:p:h") .. "/"
    local file = command_args.args
    vim.cmd.edit(directory .. file)
  end,
  { nargs = 1 }
)
