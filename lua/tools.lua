return function() 

  local function match_any_of(target, patterns)
    for i, pattern in ipairs(patterns) do
      local result = string.match(target,  pattern)
      if result then return result end
    end
    return nil
  end

  return {
    match_any_of = match_any_of
  }
end
