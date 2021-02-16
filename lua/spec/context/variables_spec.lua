-- local dbg = require("debugger")
-- dbg.auto_where = 2
local stub = require'spec.helpers.stub_vim'

local context = require'context'.context

local r = require'spec.helpers.random'
local full_path = r.random_string("full_path_")
local filetype = r.random_string("filetype_")

local buffer = r.random_strings("line_%n_", 5)
local current = buffer[3]
stub.stub_vim{ cursor = {3, 4}, lines = buffer, evaluation = {'expand("%")', full_path }, option = {"filetype", filetype}, var = {"alpha", 1} }
stub.stubber.var("beta", 2)

local ctxt = context()
describe("context of current situation", function()
  it("gets cursor", function()
    assert.are.same({3, 4}, ctxt.cursor)
  end)
  it("can add varnames", function()
    ctxt:add_variables({"alpha", "beta"})
    assert.is_equal(1, ctxt.alpha)
    assert.is_equal(2, ctxt.beta)
  end)
end)

