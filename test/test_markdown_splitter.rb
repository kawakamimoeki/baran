require 'minitest/unit'
require 'baran'

MiniTest::Unit.autorun

class TestMarkdownSplitter < MiniTest::Unit::TestCase
  def setup
    @splitter = Baran::MarkdownSplitter.new
  end

  def test_chunks
    text = "# h1\n\n## h2\n\n### h3\n\n#### h4\n\n##### h5\n\n###### h6\n\n```\n\n```\n\n***\n\n---"
    @splitter = Baran::MarkdownSplitter.new(chunk_size: 3, chunk_overlap: 1)
    chunks = @splitter.chunks(text)

    assert_equal(chunks.length, 30)
  end
end