require 'minitest/unit'
require 'baran'

MiniTest::Unit.autorun

class TestSentenceTextSplitter < MiniTest::Unit::TestCase
  def setup
    @splitter = Baran::SentenceTextSplitter.new(chunk_size: 10, chunk_overlap: 5)
  end

  def test_chunks
    story = <<~TEXT
      Hack and jill
        went up the hill to fetch
        a pail of water.  Jack fell
      down and broke his crown and Jill
        came tumbling after.
      The pail went flying!  Was the water spilled?
        No, the water was splashed on Bo Peep.
    TEXT

    chunks = @splitter.chunks(story)

    sentences = chunks
                  .map  { |chunk| 
                          chunk[:text]
                            .gsub(/\s+/, ' ')
                            .strip 
                        }

    expected  = [
      "Hack and jill went up the hill to fetch a pail of water.", 
      "Jack fell down and broke his crown and Jill came tumbling after.", 
      "The pail went flying!", 
      "Was the water spilled?", 
      "No, the water was splashed on Bo Peep."
    ]

    assert_equal(sentences, expected)
  end
end
