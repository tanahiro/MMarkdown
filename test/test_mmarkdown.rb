require 'minitest/autorun'
require 'nokogiri'

require "#{__dir__}/../lib/mmarkdown"

class MMarkdownTest < MiniTest::Test
  def test_mmarkdown
    md_string = File.open("#{__dir__}/test.mmd").read
    html_actual = MMarkdown.new(md_string).to_str

    html_expected = File.open("#{__dir__}/test.html").read

    assert_equal(Nokogiri::HTML::DocumentFragment.parse(html_expected).to_html,
                 Nokogiri::HTML::DocumentFragment.parse(html_actual).to_html)
  end

  def test_with_title
    md_string = File.open("#{__dir__}/test.mmd").read
    html_actual = MMarkdown.new(md_string,
                                title: "Test",
                                style: "#{__dir__}/test.css",
                                footer: "#{__dir__}/footer.html"
                               ).to_str

    html_expected = File.open("#{__dir__}/test_with_title.html").read

    assert_equal(Nokogiri::HTML::DocumentFragment.parse(html_expected).to_html,
                 Nokogiri::HTML::DocumentFragment.parse(html_actual).to_html)
  end

  def test_toc_html
    md_string = File.open("#{__dir__}/test.mmd").read

    mmarkdown = MMarkdown.new(md_string)
    toc_actual = mmarkdown.toc_html

    toc_expected = nil
    toc_expected = <<EOF
<ul id="markdown-toc">
  <li><a href="#test" id="markdown-toc-test">Test</a>    <ul>
      <li><a href="#equation" id="markdown-toc-equation">Equation</a></li>
      <li><a href="#markdown" id="markdown-toc-markdown">Markdown</a>        <ul>
          <li><a href="#list" id="markdown-toc-list">List</a></li>
          <li><a href="#quote" id="markdown-toc-quote">Quote</a></li>
          <li><a href="#table" id="markdown-toc-table">Table</a></li>
          <li><a href="#syntax-highlight" id="markdown-toc-syntax-highlight">Syntax highlight</a></li>
          <li><a href="#link" id="markdown-toc-link">Link</a></li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
EOF

    assert_equal(toc_expected, toc_actual)

  end

end

