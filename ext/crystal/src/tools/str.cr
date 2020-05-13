module Tools
  module Str extend self

    def with_accolade(line : String) : String
      with_suffix(line, %r{(?:\s+\{\s*)?\z}, default: " {")
    end

    def with_do(line : String) : String
      with_suffix(line, %r{(?:\s+do\s*)?\z})
    end

    def with_suffix(line : String, rgx : Regex, *, default : String = " do") : String
      line.sub(rgx, default)
    end
  end
end
