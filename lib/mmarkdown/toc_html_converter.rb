require 'kramdown/converter/html'

module Kramdown
  module Converter
    class Html
      def self.convert_toc toc, option = {}
        converter = new(Element.new(:root), ::Kramdown::Options.merge(option))
        toc_tree = converter.generate_toc_tree(toc, :ul, {})
        return converter.convert(toc_tree, 0)
      end
    end
  end
end

