module MMarkdown
  module Helper
    def to_kramdown_math_block str
      str_kr = str.clone

      str.scan(/(\s*\\\[\s*)(.*?)(\s*\\\]\s*)/) {|m|
        str_kr.gsub!(m.join,
                  "\n\n$$\n" + m[1]  + "\n$$\n\n")
      }

      return str_kr
    end

    def to_kramdown_math_inline str
      str_kr = str.clone

      str.scan(/(\\\(\s*)(.*?)(\s*\\\))/) {|m|
        str_kr.gsub!(m.join,
                  "$$ " + m[1]  + " $$")
      }

      return str_kr
    end
  end
end

