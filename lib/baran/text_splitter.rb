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

      splitted(text).each do |chunk|
        chunks << { text: chunk, cursor: cursor }
        cursor += chunk.length
      end

      chunks
    end

    def join_docs(docs, separator)
      text = docs.join(separator).strip
      text.empty? ? nil : text
    end

    def merged(splits, separator)
      docs = [] # Array of strings
      current_doc = [] # Array of strings
      total = 0

      splits.each do |d|
        len = d.length

        if total + len >= @chunk_size
          unless current_doc.empty?
            doc = join_docs(current_doc, separator)
            docs.push(doc) unless doc.nil?

            while total > @chunk_overlap || (total + len > @chunk_size && total.positive?)
              total -= current_doc.first.length
              current_doc.shift
            end
          end
        end

        current_doc.push(d)
        total += len
      end

      doc = join_docs(current_doc, separator)
      docs.push(doc) unless doc.nil?

      docs
    end
  end
end