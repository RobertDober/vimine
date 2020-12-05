return function()
  local function nop(line)
    return {
      lines = { line },
      offset = 0,
      col = 999,
    }
  end
  local function indent(line)
    return string.match(line, "^%s*")
  end

  return {
    indent = indent,
    nop    = nop
  }
end
