require "#{__dir__}/mmarkdown/mmarkdown"

module MMarkdown
  def new md_string, opts = {}
    return MMarkdown.new(md_string, opts)
  end
  module_function :new

  def load_file filename
    return MMarkdown.load_file(filename)
  end
  module_function :load_file
end

