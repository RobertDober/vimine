-- local dbg = require("debugger")
-- -- Consider enabling auto_where to make stepping through code easier to follow.
-- dbg.auto_where = 2
local get_content=require "tools.line_chunk".get_content
local list = require "tools.list"
local map = require "tools.fn".map

local function _init_from_parts(o, parts)
  local curr_idx = 1
  for _, part in ipairs(parts) do
    table.insert(o.chunks, LineChunk{content = part, start = curr_idx})
    curr_idx = curr_idx + #part
  end
  return o
end

local function _init(opts)
  local o = {}
  o.chunks = {}
  o.cursor = opts.cursor or 1 
  if opts.parts then
    return _init_from_parts(o, opts.parts)
  end
  error("Missing arguments to construct a Line: (parts)")
end


function Line(opts)
  local self = _init(opts)
  local function chunks() return self.chunks end
  local function cursor() return self.cursor end
  local function current()
    return self.chunks[self.cursor]
  end
  local function replace_current(with)
    local new_parts = list.slice(self.chunks, 1, self.cursor - 1, get_content)
    table.insert(new_parts, with)

    local delta = #current() - #with -- positive if new is shorter hence we need to substract the delta ...
    new_parts = list.append(new_parts, list.slice(self.chunks, self.cursor + 1, nil, get_content))
    -- for i, chunk in ipairs(new_chunks) do
    --   dbg(type(chunk.content()) == "string")
    --   print(i, type(chunk.content())) 
    -- end

    return Line{parts = new_parts}
  end
  return list.readonly({
    chunks  = chunks,
    cursor  = cursor,
    current = current,
    replace_current = replace_current,
  }, "Line instances are immutable")
end
