
local function cccomplete(lnb)
  vim.api.nvim_set_current_line("completed!")
end

return {
  complete = cccomplete,
}
