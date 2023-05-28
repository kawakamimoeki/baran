require_relative './text_splitter'

module Baran
  class RecursiveCharacterTextSplitter < TextSplitter
    attr_accessor :separators

    def initialize(chunk_size: 1024, chunk_overlap: 64, separators: nil)
      super(chunk_size: chunk_size, chunk_overlap: chunk_overlap)
      @separators = separators || ["\n\n", "\n", " ", ""]
    end

    def splitted(text)
      final_chunks = []

      separator = @separators.last
      @separators.each do |s|
        if s.empty?
          separator = s
          break
        elsif text.include?(s)
          separator = s
          break
        end
      end

      splits = separator.empty? ? text.chars : text.split(separator)

      good_splits = []
      splits.each do |s|
        if s.length < @chunk_size
          good_splits << s
        else
          unless good_splits.empty?
            merged_text = merged(good_splits, separator)
            final_chunks.concat(merged_text)
            good_splits.clear
          end
          other_info = splitted(s)
          final_chunks.concat(other_info)
        end
      end

      unless good_splits.empty?
        merged_text = merged(good_splits, separator)
        final_chunks.concat(merged_text)
      end

      final_chunks
    end
  end
end