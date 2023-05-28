require 'minitest/autorun'
require 'baran'

MiniTest::Unit.autorun

class TestTextSplitter < Minitest::Test
  def setup
    @splitter = Baran::TextSplitter.new
    @test_splitter = Class.new(Baran::TextSplitter) do
      def splitted(text)
        text.split(/ /)
      end
    end.new(chunk_size: 6, chunk_overlap: 2)
  end

  def test_initialize
    assert_equal 1024, @splitter.chunk_size
    assert_equal 64, @splitter.chunk_overlap

    splitter = Baran::TextSplitter.new(chunk_size: 1500, chunk_overlap: 300)
    assert_equal 1500, splitter.chunk_size
    assert_equal 300, splitter.chunk_overlap

    assert_raises RuntimeError, 'Cannot have chunk_overlap >= chunk_size' do
      Baran::TextSplitter.new(chunk_size: 1000, chunk_overlap: 1000)
    end
  end

  def test_splitted
    assert_raises NotImplementedError, 'splitted method should be implemented in a subclass' do
      @splitter.splitted('some text')
    end
  end

  def test_splitted_with_custom_text_splitter
    markdown_splitter = Baran::MarkdownSplitter.new(chunk_size: 10, chunk_overlap: 1)
    text = <<~TEXT
      ## Heading

      This is a sample text
      ---

      Another section"
    TEXT
    splitted = markdown_splitter.splitted(text)
    assert_equal ["## Heading", "This is a", "a sample", "text", "---", "Another", "section\""], splitted
  end

  def test_chunks
    text = 'text one'
    metadata = {}
    documents = @test_splitter.chunks(text)

    assert_equal 2, documents.size
    assert_equal 'text', documents[0][:text]
  end

  def test_join_docs
    docs = ['one', 'two', 'three']
    separator = ' '
    joined_text = @test_splitter.join_docs(docs, separator)

    assert_equal 'one two three', joined_text
  end

  def test_merged
    [
      { splits: ['txt', 'i', 'txt', 'o'], expected: ['txt i', 'i txt o'] },
      { splits: ['txt', 'ii', 'txt', 'o'], expected: ['txt ii', 'ii txt', 'o'] },
      { splits: ['txt', 'ii', 'tx', 'oo'], expected: ['txt ii', 'ii tx', 'tx oo'] },
    ].each do |data|
      assert_equal data[:expected], @test_splitter.merged(data[:splits], ' ')
    end
  end
end
