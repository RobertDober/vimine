require "ostruct"
require_relative "cccompleter/common"
require_relative "cccompleter/elixir"
require_relative "cccompleter/html"
require_relative "cccompleter/ruby"
require_relative "cccompleter/rust"
module CCCompleter extend self

  Completers = {
    "elixir" => Elixir,
    "html"   => HTML,
    "ruby"   => Ruby,
    "rust"   => Rust
  }

  def complete(context)
    context = OpenStruct.new(context)
    Completers.fetch(context.ft){ return context }.new(context).complete
    context
  end
end
