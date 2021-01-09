-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'nvimapi'
local chunk = require'tools.string'.chunk

local function add_variables(ctxt, args)
  for _, varname in ipairs(args) do
    ctxt[varname] = api.var(varname)
  end
end

local function context(...)
  local cursor = api.cursor()
  local ctxt = {
    api     = api,
    col = cursor[2],
    cursor = cursor,
    lnb  = cursor[1],
    line = api.line(),
    ft   = api.option('filetype'),
    file_name = api.eval('expand("%:t")'),
    file_path = api.eval('expand("%")'),

  }
  ctxt.pre_line = api.line_at(ctxt.lnb - 1)
  ctxt.post_line = api.line_at(ctxt.lnb + 1)
  add_variables(ctxt, {...})
  ctxt.add_variables = add_variables
  return ctxt 
end

local function get_selection()
  -- get mark positins and return empty table unless they are present
  local result = {}
  local fst = api.get_mark("<")
  if fst[1] == 0 then
    return result
  end
  local lst = api.get_mark(">")
  if lst[1] == 0 then
    return result
  end
  local fl = fst[1]
  local fc = math.min(fst[2], lst[2])
  local ll = lst[1]
  local lc = math.max(fst[2], lst[2])
  for i = fl, ll do
    table.insert(result, {lnb = i, chunk = chunk(api.line_at(i), fc + 1, lc + 1)})
  end
  -- print(vim.inspect(result))
  -- print(vim.inspect(result[1].chunk.replace("*****").string()))
  return result
end

local function _set_selection(selection, new_value)
  local lnb = selection.lnb
  local chunk = selection.chunk
  api.set_lines(lnb, lnb, {chunk.replace(new_value).string()})
end

local function set_selection(new_values)
  if type(new_values) == "string" then
    set_selection({new_values})
  else
    local selection = get_selection()
    for idx, new_value in ipairs(new_values) do
      _set_selection(selection[idx], new_value)
    end
  end
end

return {
  context = context,
  get_selection = get_selection,
  set_selection = set_selection
}
