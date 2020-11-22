require "lab42/open_map/include"
module Support
  module CCCompletion
    Base = OpenMap.new(
          ft: "elixir",
          cursor: [42, 4],
          lines: [],
          line_number: 42,
          path: "path"
        )
    def mk_context(**params)
      OpenStruct.new(Base.merge(**params))
    end

    def mk_ft_context(ft, **params)
      OpenStruct.new(
        Base
          .merge(**params)
          .merge(ft: ft))
    end

    def mk_md_context(**params)
      mk_ft_context("markdown", **params)
    end

    def mk_vim_context(**params)
      mk_ft_context("vim", **params)
    end

  end
end

RSpec.configure do |conf|
  conf.include Support::CCCompletion
end
