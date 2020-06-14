require_relative "completer"
require_relative "completers/elixir"
require_relative "completers/ruby"
class RubyCompleter
  attr_accessor :line
  attr_reader :cursor, :next_line, :prefix, :subject

  def self.complete(context)
    new(context).complete
  end

  def self.completers
    { "ruby" => Completers::Ruby,
      "elixir" => Completers::Elixir
    }
  end

  def col= new_col
    @cursor[-1] = new_col
  end

  def complete
    dispatch
    self
  end

  def inc_col by
    @cursor[-1] += by
  end

  private

  def dispatch
    self.class.completers.fetch(@ft).complete(self)
  end

  def initialize(context)
    @line    = context[:line]
    @next_line    = context[:next_line]
    @cursor  = context[:cursor]
    @ft      = context[:ft]
    @prefix  = @line[0...cursor.last]
    @subject = @line[cursor.last..-1]
  end

end
