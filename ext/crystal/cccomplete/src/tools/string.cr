module Tools
  module String extend self
    def with_do(line : String) : String
      with_suffix(line, %r{(?:\s+do\s*)?\z})
    end

    def with_suffix(line : String, rgx : Regex) : String
      line.sub(rgx, " do ")
    end
  end
end
