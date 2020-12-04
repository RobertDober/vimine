local api = vim.api

local function indent(line)
  return string.match(line, "^%s*")
end


local function complete_ruby_no_do(line)
  return {
    lines = {
      line,
      indent(line) .. "  ",
      indent(line) .. "end"
    },
    offset = 1,
    col = 999
  }
end

local function complete_ruby_do(line)
  line = string.gsub(line, "%s+do%s*$", "")
  print("doline", line)
  return {
    lines = {
      line .. " do",
      indent(line) .. "  ",
      indent(line) .. "end"
    },
    offset = 1,
    col = 999
  }
end

local ruby_no_do = "^%s*(%a+)"
local ruby_no_dos = {
  module = true,
  class = true,
  def = true,
}
local function complete_ruby(line)
  no_do = ruby_no_dos[string.match(line, ruby_no_do)] 
  if no_do then
    return complete_ruby_no_do(line)
  else
    return complete_ruby_do(line)
  end
end

local completers = {
  ruby = complete_ruby,
}

local function cccomplete(lnb1, lnb2)
  print("lnbs", lnb1, lnb2)
  local lines  = api.nvim_buf_get_lines(0, lnb1-1, lnb2, false) -- 0 → current buffer, false → not strict indexing
  print("lines:")
  for k, v in pairs(lines) do
    print("  "..v)
  end
  local ft     = api.nvim_buf_get_option(0, 'filetype')
  local completer = completers[ft]
  local result
  if completer then
    result = completers[ft](lines[1])
    print("result lines:")
    for k, v in pairs(result.lines) do
      print("  "..v)
    end

    api.nvim_command((lnb1).."d")
    api.nvim_buf_set_lines(0, lnb1-1, lnb1-1, false, result.lines) -- false → not strict indexing
    api.nvim_win_set_cursor(0, {lnb1+result.offset, result.col})
  end
end

return {
  complete = cccomplete,
}
