require 'minitest/unit'
require 'baran'

MiniTest::Unit.autorun

class TestCharacterTextSplitter < MiniTest::Unit::TestCase
  def setup
    @splitter = Baran::CharacterTextSplitter.new(chunk_size: 10, chunk_overlap: 5)
  end

  def test_chunks
    chunks = @splitter.chunks("Hello, world!\n\nHello, world!\n\nHello, world!")

    assert_equal(chunks.length, 3)
  end
end