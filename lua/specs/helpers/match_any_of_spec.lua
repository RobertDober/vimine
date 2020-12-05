local match_any_of = require'cccomplete.helpers'().match_any_of

describe("match_any_of", function()
  local patterns = {
    "^%s*function%s%a+",
    "^%s*local%sfunction%s%a+",
    "^%s*%a+%s*=%s*function[(]",
    "^%s*local%s+%a+%s*=%s*function[(]"
  }

  describe("matching subjects", function()
    local function spec_matching(name, subject)
      describe(name, function()
        it("matches", function()
          assert.is.truthy(match_any_of(subject, patterns))
        end)
      end)
    end

    spec_matching("global named function", " function alpha")
    spec_matching("local named function", "local function beta(")
    spec_matching("globally assigned function", " alpha = function(")
    spec_matching("locally assigned function", "local   beta = function(")
  end)

  describe("missmatching subjects", function()
    local function spec_missmatching(name, subject)
      describe(name, function()
        it("matches", function()
          assert.is.falsy(match_any_of(subject, patterns))
        end)
      end)
    end

    spec_missmatching("global named function like", " funCtion alpha")
    spec_missmatching("local named function like", "localfunction beta(")
    spec_missmatching("globally assigned function like", "beta alpha = function(")
    spec_missmatching("locally assigned function like", "local   beta = function")
  end)
end)
