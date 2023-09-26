# Baran

![v](https://badgen.net/rubygems/v/baran)
![dt](https://badgen.net/rubygems/dt/baran)
![license](https://badgen.net/github/license/moekidev/baran)

Text Splitter for Large Language Model datasets.

To avoid token constraints and improve the accuracy of vector search in the Large Language Model, it is necessary to divide the document. This gem supports splitting the text in the specified manner.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add baran

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install baran

## Usage

### Default Paramters

- `chunk_size`: 1024 (characters)
- `chunk_overlap`: 64 (characters)

### Character Text Splitter

Splitting by the specified character.

```ruby
splitter = Baran::CharacterTextSplitter.new(
    chunk_size: 1024,
    chunk_overlap: 64,
    separator: "\n\n"
)
splitter.chunks(text, metadata: { ... })
# => [{ cursor: 0, text: "...", metadata: { ... } }, ...]
```

### Recursive Character Text Splitter

Splitting by the specified characters recursively.

```ruby
splitter = Baran::RecursiveCharacterTextSplitter.new(
    separators: ["\n\n", "\n", " ", ""]
)
splitter.chunks(text, metadata: { ... })
# => [{ cursor: 0, text: "...", metadata: { ... } }, ...]
```

### Markdown Text Splitter

Splitting by the Markdown descriptions.

```ruby
splitter = Baran::MarkdownSplitter.new
splitter.chunks(markdown, metadata: { ... })
# => [{ cursor: 0, text: "...", metadata: { ... } }, ...]
```

Split with the following priority.

```ruby
[
    "\n# ", # h1
    "\n## ", # h2
    "\n### ", # h3
    "\n#### ", # h4
    "\n##### ", # h5
    "\n###### ", # h6
    "```\n\n", # code block
    "\n\n***\n\n", # horizontal rule
    "\n\n---\n\n", # horizontal rule
    "\n\n___\n\n", # horizontal rule
    "\n\n", # new line
    "\n", # new line
    " ", # space
    "" # empty
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moekidev/baran. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/moekidev/baran/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Baran project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/moekidev/baran/blob/main/CODE_OF_CONDUCT.md).
