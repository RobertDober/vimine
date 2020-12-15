local api = vim.api

local function add_variables(ctxt, args)
  for _, varname in ipairs(args) do
    ctxt[varname] = api.nvim_get_var(varname)
  end
end

local function context(...)
  local cursor = api.nvim_win_get_cursor(0)
  local ctxt = {
    col = cursor[2],
    cursor = cursor,
    lnb  = cursor[1],
    line = api.nvim_get_current_line(),
    ft   = api.nvim_buf_get_option(0, 'filetype'),
    file_name = api.nvim_eval('expand("%:t")'),
    file_path = api.nvim_eval('expand("%")')
  }
  add_variables(ctxt, {...})
  ctxt.add_variables = add_variables
  return ctxt 
end

local function context_with_lines(lnb1, lnb2, ...)
  local ctxt = context(...)
  ctxt.lines = api.nvim_buf_get_lines(0, lnb1 - 1, lnb2 - 1, false)
  ctxt.pre_line = api.nvim_buf_get_lines(0, lnb1 - 2, lnb1 - 1, false)
  ctxt.post_line = api.nvim_buf_get_lines(0, lnb1, lnb1+1, false)
  if ctxt.pre_line then
    ctxt.pre_line = ctxt.pre_line[1]
  end
  if ctxt.post_line then
    ctxt.post_line = ctxt.post_line[1]
  end
  return ctxt
end

return {
  context = context,
  context_with_lines = context_with_lines
}
