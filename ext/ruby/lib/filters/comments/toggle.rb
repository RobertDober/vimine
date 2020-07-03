require 'lab42/match'
module Toggle extend self

  FILETYPE_COMMENTS = {
  }
  def run lines, filetype
    comment = FILETYPE_COMMENTS.fetch(filetype, "# ")
    commentrgx = %r{\A(\s*)(#{comment})?}
    lines.map(&_toggle_line(comment, commentrgx))
  end

  private
  def _toggle_line comment, commentrgx
    match = Lab42::Match.new(commentrgx)
    -> line do
      return line if _empty? line
      match.match(line)
      if match[2]
        match.replace(2, "").string
      else
        match.replace(-1, comment).string
      end
    end
  end

  EMPTY_RGX = %r{\A\s*\z}
  def _empty?(line)
    EMPTY_RGX === line
  end
end
