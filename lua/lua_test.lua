local T = require'tools'()
local _context = require'context'
local context

local api     = require'vimapi'


local function lua_test_command_maker()
  local commands = {}
  local file_path = context.file_path
  context:add_variables( "vimine_lua_test_command", "vimine_lua_test_suffix", "vimine_lua_test_window")
  if context.lnb == 1 then
    file_path = "specs"
  end
  local test_args = context.vimine_lua_test_command .. ' ' .. file_path

  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_lua_test_window .. ' "' .. test_args .. '" C-m')
  if #context.vimine_lua_test_suffix > 0 then
    table.insert(commands, 'tmux send-keys -t ' .. context.vimine_lua_test_window .. ' "' .. context.vimine_lua_test_suffix .. '" C-m')
  end
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_lua_test_window )

  return commands
end

local trigger_ruby_line_spec = {
  "^%s*describe%s",
  "^%s*context%s",
  "^%s*it",
}
local function ruby_test_command_maker()
  local commands = {}
  local file_path = "spec"
  context:add_variables( "vimine_ruby_test_command", "vimine_ruby_test_suffix", "vimine_ruby_test_window")
  if context.lnb ~= 1 and string.match(context.file_name, "_spec[.]rb$") then
    file_path = context.file_path
    -- check for linenumber
    if T.match_any_of(context.line, trigger_ruby_line_spec) then
      file_path = context.file_path .. ":" .. context.lnb
    end
  end
  local test_args = context.vimine_ruby_test_command .. ' ' .. file_path

  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_ruby_test_window .. ' "' .. test_args .. '" C-m')
  if #context.vimine_ruby_test_suffix > 0 then
    table.insert(commands, 'tmux send-keys -t ' .. context.vimine_ruby_test_window .. ' "' .. context.vimine_ruby_test_suffix .. '" C-m')
  end
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_ruby_test_window )

  return commands
end

local test_command_makers = {
  lua = lua_test_command_maker,
  ruby = ruby_test_command_maker,
}

local function run_tests()
  api.command("write")
  context = _context.context()
  local test_command_maker = test_command_makers[context.ft]
  -- print("test command maker", test_command_maker)
  if not test_command_maker then return end

  local commands = test_command_maker()
  -- execute tmux commands
  for _, command in ipairs(commands) do
    -- print(command)
    api.system(command)
  end
end

return {
  run_tests = run_tests,
}
