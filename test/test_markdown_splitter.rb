require 'minitest/unit'
require 'baran'

MiniTest::Unit.autorun

class TestMarkdownSplitter < MiniTest::Unit::TestCase
  def setup
    @splitter = Baran::MarkdownSplitter.new
  end

  def test_chunks
    text = <<~MARKDOWN
# h1

## h2

### h3

#### h4

##### h5

###### h6

```
```

***

---
MARKDOWN

    @splitter = Baran::MarkdownSplitter.new(chunk_size: 3, chunk_overlap: 1)
    chunks = @splitter.chunks(text)

    assert_equal(13, chunks.length)
  end
end
