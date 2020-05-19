class RubyCompleter
  attr_reader :cursor, :line, :prefix, :subject

  def self.complete(context)
    new(context).complete
  end

  def self.completions
    [
      [%r{\A:(\w+)}, :symbol_to_string],
      [%r{\A(\w+):\s+}, :kwd_to_hash_rocket],
    ]
  end

  def complete
    dispatch
    self
  end

  private

  def dispatch
    self.class.completions.find { |(creg, chandler)|
      m = creg.match(subject)
      if m
        send(chandler, creg, m)
      end
    }
  end

  def initialize(context)
    @line = context[:line]
    @cursor = context[:cursor]
    @prefix = @line[0...cursor.last]
    @subject = @line[cursor.last..-1]
  end

  def kwd_to_hash_rocket rgx, m
    @line = prefix + subject.sub(rgx, %{"#{m[1]}" => })
  end

  def symbol_to_string rgx, m
    @line = prefix + subject.sub(rgx, %{"#{m[1]}"})
  end
end
