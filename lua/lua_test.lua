local T = require'tools'()
local map = require'tools.fn'.map
local _context = require'context'
local context
local api


local function elixir_extract_test_tag()
  local tag = string.match(context.line, '^%s*@tag :(%w+)')
  tag = tag or string.match(context.line, '^%s*@moduletag :(%w+)')
  if tag then
    return " --trace --only " .. tag .. " "
  else
    return " --trace "
  end
end

local trigger_elixir_line_spec = {
  "^%s*describe%s",
  "^%s*context%s",
  "^%s*test",
}

local function crystal_test_command_maker()
  local commands = {}
  local file_path = context.file_path
  local test_args = context.vimine_crystal_test_command .. " " .. file_path
  if context.lnb == 1 then
    test_args = context.vimine_crystal_test_general_command
  end

  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_crystal_test_window .. ' "' .. test_args .. '" C-m')
  if #context.vimine_crystal_test_suffix > 0 then
    table.insert(commands, 'tmux send-keys -t ' .. context.vimine_crystal_test_window .. ' "' .. context.vimine_crystal_test_suffix .. '" C-m')
  end
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_crystal_test_window )
  return commands
end

local function elixir_test_command_maker()
  local commands = {}
  local file_path = context.file_path
  local tag = elixir_extract_test_tag()
  if T.match_any_of(context.line, trigger_elixir_line_spec) then
    file_path = file_path .. ":" .. context.lnb
  end
  local test_args = context.vimine_elixir_test_command .. tag .. file_path
  if context.lnb == 1 then
    test_args = context.vimine_elixir_test_general_command
  end

  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_elixir_test_window .. ' "' .. test_args .. '" C-m')
  if #context.vimine_elixir_test_suffix > 0 then
    table.insert(commands, 'tmux send-keys -t ' .. context.vimine_elixir_test_window .. ' "' .. context.vimine_elixir_test_suffix .. '" C-m')
  end
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_elixir_test_window )

  return commands
end

local function lua_extract_test_tag()
  local tag = string.match(context.line, '#(%w+)"')
  if tag then
    return " -t " .. tag .. " "
  else
    return " "
  end
end

local function lua_test_command_maker()
  local commands = {}
  local file_path = context.file_path
  -- context:add_variables( "vimine_lua_test_general_command", "vimine_lua_test_command", "vimine_lua_test_suffix", "vimine_lua_test_window")
  local tag = lua_extract_test_tag() 
  local test_args = context.vimine_lua_test_command .. tag .. file_path
  if context.lnb == 1 then
    test_args = context.vimine_lua_test_general_command
  end

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
  -- context:add_variables( "vimine_ruby_test_command", "vimine_ruby_test_suffix", "vimine_ruby_test_window")
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
  crystal = crystal_test_command_maker,
  elixir = elixir_test_command_maker,
  lua = lua_test_command_maker,
  ruby = ruby_test_command_maker,
}

local test_var_suffices = {
  "command", "general_command", "suffix", "window"
}
local function run_tests()
  context = _context.context()
  api = context.api
  api.command("write")
  local test_command_maker = test_command_makers[context.ft]
  -- print("test command maker", test_command_maker)
  if not test_command_maker then return end

  local var_names =
    map(test_var_suffices,
      function(suffix)
        return "vimine_" .. context.ft .. "_test_" .. suffix
      end)
  context:add_variables(var_names)
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
