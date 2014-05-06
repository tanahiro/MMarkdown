require 'minitest/autorun'
require 'nokogiri'

require "#{__dir__}/../lib/mmarkdown"

class MMarkdownTest < MiniTest::Test
  def test_mmarkdown
    md_string = File.open("#{__dir__}/test.md").read
    html_actual = MMarkdown.new(md_string).to_str

    html_expected = File.open("#{__dir__}/test.html").read

    assert_equal(Nokogiri::HTML::DocumentFragment.parse(html_expected).to_html,
                 Nokogiri::HTML::DocumentFragment.parse(html_actual).to_html)
  end

  def test_toc_html
    md_string = File.open("#{__dir__}/test.md").read

    mmarkdown = MMarkdown.new(md_string)
    toc_actual = mmarkdown.toc_html

    toc_expected = <<EOF
<ul>
<li>
<a href="#test">Test</a>
<ul>
<li>
<a href="#equation">Equation</a>
</li>
<li>
<a href="#markdown">Markdown</a>
<ul>
<li>
<a href="#list">List</a>
</li>
<li>
<a href="#quote">Quote</a>
</li>
<li>
<a href="#table">Table</a>
</li>
<li>
<a href="#syntax-highlight">Syntax highlight</a>
</li>
<li>
<a href="#link">Link</a>
</li>
</ul>
</li>
</ul>
</li>
</ul>
EOF

    assert_equal(toc_expected, toc_actual)

  end
end

