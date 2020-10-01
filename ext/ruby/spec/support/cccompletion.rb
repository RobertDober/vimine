module Support
  module CCCompletion
    def mk_context(**params)
      OpenStruct.new(
        {
          ft: "elixir",
          cursor: [42, 4],
          lines: [],
          line_number: 42,
          path: "path"
        }.merge(params)
      )
    end

    def mk_vim_context(**params)
      OpenStruct.new(
        {
          ft: "vim",
          cursor: [42, 4],
          lines: [],
          line_number: 42,
          path: "path"
        }.merge(params)
      )
    end
  end
end

RSpec.configure do |conf|
  conf.include Support::CCCompletion
end
