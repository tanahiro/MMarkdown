require "math_ml/string"
require "redcarpet"

require "#{__dir__}/mmarkdown/version"

class MMarkdown
  def initialize md_string
    @md_mathml = equations_to_mathml(md_string)

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
  end

  def equations_to_mathml string
    equations = []

    string_mathml = string.clone
    string.scan(/\\\[(.*)\\\]/) {|m|
      string_mathml.gsub!("\\[" + m.first + "\\]", m.first.to_mathml(true).to_s)
    }

    string.scan(/\\\((.*)\\\)/) {|m|
      string_mathml.gsub!("\\(" + m.first + "\\)", m.first.to_mathml.to_s)
    }

    return string_mathml
  end

  def toc_html nesting_level = 3
    render_toc = Redcarpet::Render::HTML_TOC.new
    toc_html = Redcarpet::Markdown.new(render_toc).render(@md_mathml)

    return toc_html
  end

  def to_str
    @md.to_str
  end
end

