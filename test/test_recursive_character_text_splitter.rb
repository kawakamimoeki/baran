require 'minitest/unit'
require 'baran'

MiniTest::Unit.autorun

class TestRecursiveCharacterTextSplitter < MiniTest::Unit::TestCase
  def setup
    @splitter = Baran::RecursiveCharacterTextSplitter.new(chunk_size: 7, chunk_overlap: 5)
  end

  def test_chunks
    chunks = @splitter.chunks("Hello, world!\n\nHello, world!\n\nHello, world!")

    assert_equal(chunks.length, 6)
  end


  def test_empty_chunks
    chunks = @splitter.chunks("\n\nHello, world!\n\nHello, world!\n\nHello, world!")

    assert_equal(chunks.length, 6)
  end
end
