return function() 

  local function access_by_match(source, table)
    for pattern, value in pairs(table) do
      if string.match(source, pattern) then
        return value
      end
    end
  end

  local function match_any_of(target, patterns)
    for i, pattern in ipairs(patterns) do
      local result = string.match(target,  pattern)
      if result then return result end
    end
    return nil
  end

  return {
    access_by_match = access_by_match,
    match_any_of = match_any_of,
  }
end
