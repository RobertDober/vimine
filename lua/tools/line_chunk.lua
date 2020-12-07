-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2

local readonly = require'tools.list'.readonly
local function _init(opts)
  local o = {}
  if not opts.content then error("missing keyword `content'") end
  o.content = opts.content
  if opts.start then
    o.startpos = opts.start
    o.endpos =  o.startpos + #o.content - 1
  elseif opts.matching then
    local match = string.match(opts.content, opts.matching)
    if match then
      o.content = match
      o.startpos = #opts.content - #match + 1 
      o.endpos =  o.startpos + #match - 1
    else
      o.content  = ""
      o.startpos = 0
      o.endpos   = 0
    end
    
  end
  if not o.startpos then error("startpos cannot be determined with given arguments") end
  return o
end

function LineChunk(opts)
  local self = _init(opts)
  local function content() return self.content end
  local function endpos() return self.endpos end
  local function startpos() return self.startpos end
  
  local function adjust_positions(delta)
    return LineChunk{content = self.content, start = self.startpos + delta}
  end

  return readonly({
    adjust_positions = adjust_positions,
    content = content,
    endpos = endpos,
    startpos = startpos,
  }, "LineChunk instances are immutable")
end

return {
  get_content = function(ch) return ch.content() end,
  get_startpos = function(ch) return ch.startpos() end,
  get_endpos = function(ch) return ch.endpos() end,
}
