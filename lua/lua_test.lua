local _context = require'context'
local context

local api     = require'vimapi'

local test_command_makers = {
  lua = lua_test_command_maker,
}

local function lua_test_command_maker()
  local commands = {}
  local file_path = context.file_path
  if context.lnb == 1 then
    file_path = "specs"
  end
  local test_args = context.vimine_lua_test_command .. ' ' .. file_path

  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_lua_test_window .. ' "' .. test_args .. '" C-m')
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_lua_test_window )

  return commands
end

local test_command_makers = {
  lua = lua_test_command_maker,
}
local function run_tests()
  context = _context.context("vimine_lua_test_command", "vimine_lua_test_window")
  local test_command_maker = test_command_makers[context.ft]
  -- print("test command maker", test_command_maker)
  if not test_command_maker then return end

  local commands = test_command_maker()
  -- execute tmux commands
  for _, command in ipairs(commands) do
    print(command)
    api.system(command)
  end
  -- print(test_command)
end

return {
  run_tests = run_tests,
}
