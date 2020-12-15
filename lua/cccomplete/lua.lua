local H = require "cccomplete.helpers"()
local T = require "tools"()

local busted_fn_pattern = "^%s*([%l_]+)[(]?"
local busted_fn_names = {
  context = true,
  describe = true,
  expose = true,
  insulate = true,
  it = true,
}
local busted_single_names = {
  before_each = true,
  setup = true,
  teardown = true,
}

local function_def_patterns = {
  "^%s*function%s+[%a_]+",
  "^%s*local%s+function%s+[%a_]+",
  "^%s*[%a_]+%s+=%s+function",
  "=%s+function%s*$",
  "=%s+function()%s*$",
  "=%s+function%b()%s*$",
  "^%s*return%s+function",
}

local else_patten = "^%s*else%s*$"

local function fn_complete_bare(line)
  local line = string.gsub(line, "fn%s*$", "function")
  line = string.gsub(line, "function%s*$", "function()")
  return H.complete_with_end(line, {suffix=")"} )
end

local function fn_complete_parens(line)
  return H.complete_with_end(line, {suffix=")"} )
end

local fn_patterns = { 
  ["[(,]%s*function%s*$"] = fn_complete_bare,
  ["[(,]%s*fn%s*$"] = fn_complete_bare,
  ["[(,]%s*function%b()%s*$"] = fn_complete_parens,
}

local if_patterns = {
  "^%s*if%s",
  "^%s*elseif%s"
}

return function()

  local function complete_busted(line, nocomma)
    local comma
    local open_paren = "^(%s*[%l_]+)%s"
    local line = string.gsub(line, "function[()%s]*$", "")
    line = string.gsub(line, open_paren, "%1(")

    if nocomma then
      comma = "("
      line = string.gsub(line, "[()]?%s*$", "")
    else
      comma = ", "
      line = string.gsub(line, "[,)]?%s*$", "")
    end

    return H.complete_with_end(line .. comma .. "function()", {suffix=")"} )
  end

  local function complete_function_def(line)
    local add
    if string.match(line, "%b()") then
      add = ""
    elseif string.match(line, "[(]") then
      add = ")"
    else
      add = "()"
    end
    return H.complete_with_end(line .. add)
  end

  local function complete_if(line, nosuffix)
    local suffix = " then"
    if nosuffix then
      suffix = ""
    end
    local line = string.gsub(line, "%s+then%s*$", "") .. suffix
    return H.complete_with_end(line)
  end

  local function complete_object(line)
    local line = string.gsub(line, "%s+{%s*$", " {")
    return H.complete_with_custom(line, "}")
  end

  local function maybe_complete_busted(line, match)
    if not match then return nil end
    if busted_fn_names[match] then
      -- print("busted fn", match, line)
      return complete_busted(line)
    elseif busted_single_names[match] then
      -- print("busted single", match)
      return complete_busted(line, true)
    end
  end

  local function complete(ctxt)
    local line = ctxt.line
    local match = string.match(line, busted_fn_pattern)
    local completion = maybe_complete_busted(line, match)
    if completion then 
      return completion
    end
    if T.match_any_of(line, function_def_patterns) then
      return complete_function_def(line)
    elseif T.match_any_of(line, if_patterns) then
      return complete_if(line)
    elseif string.match(line, else_patten) then
      return complete_if(line, true)
    elseif string.match(line, "%s+{%s*$") then
      return complete_object(line)
    else
      fn_completer = T.access_by_match(line, fn_patterns)
      if fn_completer then return fn_completer(line) end
      return H.complete_with_do(ctxt)
    end
  end

  return {
    complete = complete
  }
end
