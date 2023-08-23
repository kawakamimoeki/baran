require 'logger'

module Baran
  class TextSplitter
    attr_accessor :chunk_size, :chunk_overlap

    def initialize(chunk_size: 1024, chunk_overlap: 64)
      @chunk_size = chunk_size
      @chunk_overlap = chunk_overlap
      raise "Cannot have chunk_overlap >= chunk_size" if @chunk_overlap >= @chunk_size
    end

    def splitted(text)
      raise NotImplementedError, "splitted method should be implemented in a subclass"
    end

    def chunks(text)
      cursor = 0
      chunks = []

      splitted(text).compact.each do |chunk|
        chunks << { text: chunk, cursor: cursor }
        cursor += chunk.length
      end

      chunks
    end

    def joined(items, separator)
      text = items.join(separator).strip
      text.empty? ? nil : text
    end

    def merged(splits, separator)
      results = [] # Array of strings
      current_splits = [] # Array of strings
      total = 0

      splits.each do |split|
        if total + split.length >= chunk_size && current_splits.length.positive?
          results << joined(current_splits, separator)

          while total > chunk_overlap || (total + split.length >= chunk_size && total.positive?)
            total -= current_splits.first.length
            current_splits.shift
          end
        end

        current_splits << split
        total += split.length
        Logger.new(STDOUT).warn("Created a chunk of size #{total}, which is longer than the specified #{@chunk_size}") if total > @chunk_size
      end

      results << joined(current_splits, separator)

      results
    end
  end
end