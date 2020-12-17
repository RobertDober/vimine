-- local dbg = require("debugger")
-- dbg.auto_where = 2

local api = require'nvimapi'

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
    file_path = api.eval('expand("%")')
  }
  ctxt.pre_line = api.line_at(ctxt.lnb - 1)
  ctxt.post_line = api.line_at(ctxt.lnb + 1)
  add_variables(ctxt, {...})
  ctxt.add_variables = add_variables
  return ctxt 
end

return {
  context = context,
}
