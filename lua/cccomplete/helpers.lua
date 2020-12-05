return function()
  local function indent(line, suffix)
    local suffix = suffix or ""
    return string.match(line, "^%s*") .. suffix
  end

  local function complete_with_do(line, indnt)
    local indnt = indnt or 2
    local line = string.gsub(line, "%s+do%s*$", "")
    return {
      lines = {
        line .. " do",
        indent(line, string.rep(" ", indnt)),
        indent(line, "end")
      },
      offset = 1,
      col = 999
    }
  end

  local function complete_with_end(line, options)
    local options = options or {}
    local indnt = options.indnt or 2
    local suffix = options.suffix or ""
    return {
      lines = {
        line,
        indent(line, string.rep(" ", indnt)),
        indent(line, "end" .. suffix)
      },
      offset = 1,
      col = 999
    }
  end


  local function match_any_of(target, patterns)
    for i, pattern in ipairs(patterns) do
      if string.match(target,  pattern) then return true end
    end
    return false
  end

  local function nop(line)
    return {
      lines = { line },
      offset = 0,
      col = 999,
    }
  end

  return {
    complete_with_do = complete_with_do,
    complete_with_end = complete_with_end,
    indent = indent,
    match_any_of = match_any_of,
    nop    = nop
  }
end
