# frozen_string_literal: true

module Baran
  class SentenceTextSplitter < TextSplitter
    def initialize(chunk_size: 1024, chunk_overlap: 64)
      super(chunk_size: chunk_size, chunk_overlap: chunk_overlap)
    end

    def splitted(text)
      # Use a regex to split text based on the specified sentence-ending characters followed by whitespace
      text.scan(/[^.!?]+[.!?]+(?:\s+)/).map(&:strip)
    end
  end
end
