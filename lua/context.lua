local api = vim.api

local function context(...)
  local ctxt = {
    line = api.nvim_get_current_line(),
    ft   = api.nvim_buf_get_option(0, 'filetype'),
    file_name = api.nvim_eval('expand("%:t")'),
  }
  for _, varname in ipairs(arg) do
    o[varname] = api.nvim_get_var(varname)
  end
  return o
end

return {
  context = context
}

