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
end

