-- local dbg = require("debugger")
-- dbg.auto_where = 2
local _context = require'context'

local function determine_file(context)
  if string.match(context.line, "^[%w/_.]+:[%d]+:[%d]+") then
    return string.gsub(context.line, ":[%d]+:[%d].*", "")
  else
    return context.file_path
  end
end

local function run()
  local commands = {}
  context = _context.context()
  context:add_variables({"vimine_tmux_again_window"})
  local file = determine_file(context)
  table.insert(commands, 'tmux send-keys -t ' .. context.vimine_tmux_again_window .. ' "rubocop ' .. file .. '" C-m')
  table.insert(commands, 'tmux select-window -t ' .. context.vimine_tmux_again_window)
  -- execute tmux commands
  for _, command in ipairs(commands) do
    -- print(command)
    context.api.system(command)
  end
end

return {
  run = run,
}
