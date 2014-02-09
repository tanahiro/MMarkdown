require "math_ml/string"
require "redcarpet"

require "#{__dir__}/mmarkdown/version"

class MMarkdown

  def initialize md_string
    md_mathml = equations_to_mathml(md_string)

    renderer = Redcarpet::Render::HTML

    parse_extensions = {no_intra_emphasis: true,
                        tables: true,
                        fenced_code_blocks: true,
                        autolink: true,
                        disable_indented_code_blocks: true,
                        underline: true,
                        highlight: true,
                        footnotes: true}

    render_extensions = {with_toc_data: true}

    render = renderer.new(render_extensions)

    @md = Redcarpet::Markdown.new(render, parse_extensions).render(md_mathml)
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

  def to_str
    @md.to_str
  end
end

