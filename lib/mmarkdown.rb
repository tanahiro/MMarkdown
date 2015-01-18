require "math_ml/string"
require "redcarpet"

require "#{__dir__}/mmarkdown/version"

class MMarkdown
  def self.load_file filename
    str = File.open(filename).read

    return self.new(str)
  end

  def initialize md_string, title: nil, style: nil, footer: nil
    @md_mathml = equations_to_mathml(md_string)

    @md_mathml.gsub!(/%%.*$/, '')

    parse_extensions = {no_intra_emphasis: true,
                        tables: true,
                        fenced_code_blocks: true,
                        autolink: true,
                        disable_indented_code_blocks: false,
                        superscript: true,
                        underline: true,
                        highlight: true,
                        footnotes: true}

    render_extensions = {with_toc_data: true}

    render = Redcarpet::Render::HTML.new(render_extensions)

    @md = Redcarpet::Markdown.new(render, parse_extensions).render(@md_mathml)

    if title or style or footer
      @header  = "<!DOCTYPE html>\n"
      @header += "<html>\n"
      @header += "<head>\n"

      if title
        @header += "  <title>" + title + "</title>\n"
      end

      if style
        style_str = "  <style type=\"text/css\">\n"
        File.open(style).each_line {|line|
          style_str += ("    " + line)
        }

        @header += style_str
        @header += "  </style>\n"
      end

      @header += "</head>\n"
      @header += "<body>\n"

      @footer = ""
      if footer
        @footer += "<footer>\n"
        @footer += File.open(footer).read
        @footer += "</footer>\n"
      end
      @footer += "</body>\n</html>\n"
    end
  end

  ##
  # Converts equations to MathML format
  def equations_to_mathml string
    equations = []

    string_mathml = string.clone
    string.scan(/\\\[(.*?)\\\]/) {|m|
      string_mathml.gsub!("\\[" + m.first + "\\]", m.first.to_mathml(true).to_s)
    }

    string.scan(/\\\((.*?)\\\)/) {|m|
      string_mathml.gsub!("\\(" + m.first + "\\)", m.first.to_mathml.to_s)
    }

    return string_mathml
  end

  ##
  # Returns list of table of contetns
  def toc_html nesting_level = 3
    render_toc = Redcarpet::Render::HTML_TOC.new(nesting_level: nesting_level)
    toc_html = Redcarpet::Markdown.new(render_toc).render(@md_mathml)

    return toc_html
  end

  ##
  # Returns HTML
  def to_str
    str = ""
    if @header
      str += @header
    end

    str += @md.to_str

    if @footer
      str += @footer
    end

    return str
  end
  alias :to_html :to_str
end

