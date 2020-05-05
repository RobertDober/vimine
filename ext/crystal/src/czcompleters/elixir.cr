require "./generic_completer"
module CZCompleters
  class Elixir < GenericCompleter

    DefRgx    = %r{\A\s*defp?\s+(\w+)}
    ModuleRgx = %r{\A(?:def)?module\s*\z}
    SpecRgx   = %r{\A\s*@spec\s*\z}

    def complete : Array(String)
      case @lines.first
      when SpecRgx
        complete_spec
      when ModuleRgx
        complete_default
      else
        complete_default
      end
      result
    end


    private def complete_spec
      spec, cursor = make_spec
      if cursor > 0 
        @output << spec
        @output << @lines[1]
        @commands << "call cursor(#{@lnb}, #{cursor})"
      else
        complete_default
      end
    end

    private def make_spec : Tuple(String, UInt64)
      md = DefRgx.match(@lines[1])
      if md
        make_spec_from_name(md[1])
      else
        {"", UInt64.new(0)}
      end
    end

    private def make_spec_from_name(name : String) : Tuple(String, UInt64)
      spec = "#{@prefix}@spec #{name}() :: "
      cursor = @prefix.size + 7 + name.size
      {spec, cursor.to_u64}
    end
  end
end
