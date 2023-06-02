require_relative './text_splitter'

module Baran
  class RecursiveCharacterTextSplitter < TextSplitter
    attr_accessor :separators

    def initialize(chunk_size: 1024, chunk_overlap: 64, separators: nil)
      super(chunk_size: chunk_size, chunk_overlap: chunk_overlap)
      @separators = separators || ["\n\n", "\n", " "]
    end

    def splitted(text)
      results = []
      good_splits = []
      separator = ''

      separators.each do |s|
        if text.include?(s)
          separator = s
          break
        end
      end

      text.split(separator).each do |s|
        if s.length < chunk_size
          good_splits << s
        else
          if good_splits.length.positive?
            results += merged(good_splits, separator)
            good_splits.clear
          end
          results += splitted(s)
        end
      end

      if good_splits.length.positive?
        results += merged(good_splits, separator)
      end

      results
    end
  end
end