require "kramdown"
require "#{__dir__}/helper"
require "#{__dir__}/toc_html_converter"

module MMarkdown
  class MMarkdown
    include Helper

    def self.load_file filename
      str = File.open(filename).read

      return self.new(str)
    end

    def initialize md_string, title: nil, style: nil, footer: nil
      ## Math equation
      @mmd = convert_math_boundaries(md_string)

      ## Comment out
      @mmd.gsub!(/%%.*$/, '')

      @md = Kramdown::Document.new(@mmd, math_engine: "itex2mml")

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
    # Converts Math boundaries for Kramdown
    def convert_math_boundaries string
      string_mathml = string.clone

      ## Block equation
      string_mathml = to_kramdown_math_block(string_mathml)

      ## Inline equation
      string_mathml = to_kramdown_math_inline(string_mathml)

      return string_mathml
    end

    ##
    # Returns list of table of contetns
    def toc_html nesting_level = 3
      toc = @md.to_toc
      toc_array = []
      toc_to_array(toc, toc_array, nesting_level)

      return Kramdown::Converter::Html.convert_toc(toc_array)
    end

    ##
    # Returns HTML
    def to_str
      str = ""
      if @header
        str += @header
      end

      str += @md.to_html

      if @footer
        str += @footer
      end

      return str
    end
    alias :to_html :to_str

    def toc_to_array toc, ary, nesting_level
      toc.children.each do |t|
        ary << [t.value.options[:level], t.attr[:id], t.value.children]

        if t.value.options[:level] < nesting_level
          toc_to_array(t, ary, nesting_level)
        end
      end
    end
  end
end

