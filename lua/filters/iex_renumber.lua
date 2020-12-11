-- local sm = require 'tools.state_machine'.state_machine

-- local iex_line_patterns = {
--   "^%s%s%s%s+iex>",
--   "^%s%s%s%s+iex[(]%d+[)]>"
-- }
-- local cont_line_patterns = {
--   "^%s%s%s%s+[.][.][.]>",
--   "^%s%s%s%s+[.][.][.][(]%d+[)]>",
-- }

--   def run(lines)
--     machine = _mk_machine
--     machine.run([0, ""], lines)
--     machine.output
--   end

-- local state_machine = sm{
--   states = {
--     start = {
--       ["^%s%s%s%s+iex>"] = ,
--       ["^%s%s%s%s+iex[(]%d+[)]>" =

--     }
--   }
-- }
  



--   private

--   def _mk_machine
--     Lab42::StateMachine.new "the IEX Renumber Machine" do
--       state :start do
--         trigger IEX_LINE_RGX, :iex  do |(count, _), match|
--           prefix = match[1] 
--           new =
--             match
--               .replace(2, "iex")
--               .replace(3, count.succ)
--           [new, [count.succ, prefix]] 
--         end

--         trigger LAZY_IEX_RGX, :iex do |(count, _), match|
--           prefix = match[1] 
--           new =
--             match
--               .replace(2, "iex(#{count.succ})")
--           [new, [count.succ, prefix]] 
--         end
--       end

--       state :iex do
--         trigger IEX_LINE_RGX do |(count, prefix), match|
--           new =
--             match
--               .replace(1, prefix)
--               .replace(2, "...")
--               .replace(3, count)
--           [new, [count, prefix]]
--         end

--         trigger LAZY_IEX_RGX do |(count, prefix), match|
--           new =
--             match
--               .replace(1, prefix)
--               .replace(2, "...(#{count})")
--           [new, [count, prefix]]
--         end
--         # trigger %r{\A(\s{4,})>} do |(count, prefix), match|
--         #   new =
--         #     match
--         #       .replace(1, "#{prefix}...(#{count})")
--         #   [new, [count, prefix]]
--         # end
--         trigger true, :start
--       end
--     end
--   end

-- end
