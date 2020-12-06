local H = require "cccomplete.helpers"()

local busted_fn_pattern = "^%s*([%l_]+)[(]?"
local busted_fn_names = {
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
  "^%s*local%s+[%a_]+%s+=%s+function",
}

local else_patten = "^%s*else%s*$"
local if_patterns = {
  "^%s*if%s",
  "^%s*elseif%s"
}

return function()

  local function complete_busted(line, nocomma)
    local comma
    local line = string.gsub(line, "function[()%s]*$", "")

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

    local function complete(line)
      local match = string.match(line, busted_fn_pattern)
      if match then
        if busted_fn_names[match] then
          -- print("busted fn", match, line)
          return complete_busted(line)
        elseif busted_single_names[match] then
          -- print("busted single", match)
          return complete_busted(line, true)
        elseif H.match_any_of(line, function_def_patterns) then
          return complete_function_def(line)
        elseif H.match_any_of(line, if_patterns) then
          return complete_if(line)
        elseif string.match(line, else_patten) then
          return complete_if(line, true)
        else
          return H.complete_with_do(line)
        end
      end
    end

    return {
      complete = complete
    }
  end
