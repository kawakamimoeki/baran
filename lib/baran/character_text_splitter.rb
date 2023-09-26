require_relative './text_splitter'

module Baran
  class CharacterTextSplitter < TextSplitter
    attr_accessor :separator

    def initialize(chunk_size: 1024, chunk_overlap: 64, separator: nil)
      super(chunk_size: chunk_size, chunk_overlap: chunk_overlap)
      @separator = separator || "\n\n"
    end

    def splitted(text)
      splits = separator.empty? ? text.chars : text.split(separator)
      merged(splits, @separator)
    end
  end
end
