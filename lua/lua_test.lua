local context = require'context'.context("vimine_lua_test_command", "vimine_lua_test_window")
local api     = require'vimapi'
local api = vim.api

local test_command_makers = {
  lua = lua_test_command_maker,
}

local function run_test()
  -- TODO: move into a helper
  local line         = api.nvim_get_current_line()
  local ft           = api.nvim_buf_get_option(0, 'filetype')
  local test_command = api.nvim_get_var("vimine_lua_test_command")
  local test_window  = api.nvim_get_var("vimine_lua_test_window")
  local file_name    = api.nvim_eval('expand("%:t")')
  local test_command_maker = test_command_makers[ft]
  local ctxt = context
  if not test_command_makers then return end

  -- execute tmux commands
  api.nvim_command("exec system('tmux select-window -t " .. test_window .."')")
end

return {
  run_test = run_test,
}
