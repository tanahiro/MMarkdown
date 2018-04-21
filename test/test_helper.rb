require 'minitest/autorun'

require "#{__dir__}/../lib/mmarkdown/helper"

class MMarkdownHelperTest < MiniTest::Test
  include MMarkdown::Helper

  def test_to_kramdown_math_block
    expected = "\n\n$$\n" +
      %q"\int_{-\infty}^{\infty} f \left( x \right) \, dx" +
      "\n$$\n\n"

    str = %q"\[ \int_{-\infty}^{\infty} f \left( x \right) \, dx \]"
    assert_equal(expected, to_kramdown_math_block(str))

    str = "\n" +
      %q"\[ \int_{-\infty}^{\infty} f \left( x \right) \, dx \]" +
      "\n"
    assert_equal(expected, to_kramdown_math_block(str))

    str = "\n\\[\n" +
      %q"\int_{-\infty}^{\infty} f \left( x \right) \, dx" +
      "\n\\]\n"
    assert_equal(expected, to_kramdown_math_block(str))
  end

  def test_to_kramdown_math_inline
    expected = "$$ x^2 + y^2 = r^2 $$"

    str = %q"\( x^2 + y^2 = r^2 \)"
    assert_equal(expected, to_kramdown_math_inline(str))
  end
end

