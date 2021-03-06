-- local dbg = require("debugger")
-- dbg.auto_where = 2
local T = require "tools"()

return function()
  local function indent(line, suffix)
    local suffix = suffix or ""
    return string.match(line, "^%s*") .. suffix
  end
  
  local function make_return_object(opts)
    return {
      lines = opts.lines or {},
      offset = opts.offset or 1,
      col = opts.col or 999
    }
  end

  local function complete_from_patterns(ctxt, all_patterns, alternative)
    for _, current_patterns in ipairs(all_patterns) do
      local fn_completer = T.access_by_match(ctxt.line, current_patterns)
      if fn_completer then return fn_completer(ctxt) end
    end
    if alternative then return alternative(ctxt) end
  end

  local function complete_with_custom(line, custom, indnt)
    local indnt = indnt or 2
    local lines = {
        line,
        indent(line, string.rep(" ", indnt)),
        indent(line, custom)
      }
    return make_return_object{ lines=lines }
  end

  local function complete_with_do(ctxt, indnt)
    local indnt = indnt or 2
    local line = string.gsub(ctxt.line, "%s+do%s*$", "")
    line = string.gsub(line, "%s+$", "")
    local lines = {
        line .. " do",
        indent(line, string.rep(" ", indnt)),
        indent(line, "end")
    }
    return make_return_object{lines=lines}
  end

  local function complete_with_end(line, options)
    local options = options or {}
    local suffix = options.suffix or ""
    return complete_with_custom(line, "end" .. suffix, options.indnt)
  end


  local function nop(line)
    return make_return_object{lines={line}, offset=0}
  end

  return {
    complete_from_patterns = complete_from_patterns,
    complete_with_custom = complete_with_custom,
    complete_with_do = complete_with_do,
    complete_with_end = complete_with_end,
    indent = indent,
    match_any_of = require("tools")().match_any_of,
    make_return_object = make_return_object,
    nop    = nop
  }
end

