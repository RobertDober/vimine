command! MakeWIP :.luado return string.gsub(line, '"(.*)"', '"%1 #wip"')
command! UnMakeWIP :%s/\s*#wip//
