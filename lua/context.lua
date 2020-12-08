local api = vim.api

local function add_variables(self, args)
  for _, varname in ipairs(args) do
    self[varname] = api.nvim_get_var(varname)
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
  add_variables(ctx, {...})
  ctxt.add_variables = add_variables
  return ctxt 
end

return {
  context = context
}
