LineChunk = {}

local function _init(o, opts)
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
end

function LineChunk:new(opts)
  local o = {}
  _init(o, opts)
  local proxy = {}
  local mt = {
    __index = o,
    __newindex = function(t, k, v) error("LineChunk instances are immutable") end
  }
  setmetatable(proxy, mt)
  return proxy 
end
