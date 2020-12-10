-- keep usage of vim api in a minimal scope, this file only
local api = vim.api

local completers = {
  lua      = require("cccomplete.lua")(),
  markdown = require("cccomplete.markdown")(),
  ruby     = require("cccomplete.ruby")(),
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
    result = completer.complete(lines[1]) 
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
