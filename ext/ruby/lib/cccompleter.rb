require "ostruct"
require_relative "cccompleter/common"
require_relative "cccompleter/elixir"
require_relative "cccompleter/ruby"
module CCCompleter extend self

  Completers = {
    "elixir" => Elixir,
    "ruby"   => Ruby
  }

  def complete(context)
    context = OpenStruct.new(context)
    Completers.fetch(context.ft){ return context }.new(context).complete
    context
  end
end
