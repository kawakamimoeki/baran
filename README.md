# Baran

Text Splitter for Large Language Model datasets.

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
splitter.chunks(text)
```

### Recursive Character Text Splitter

Splitting by the specified characters recursively.

```ruby
splitter = Baran::RecursiveCharacterTextSplitter.new(
    separators: ["\nn", "\n", " ", ""]
)
splitter.chunks(text)
```

### Markdown Text Splitter

Splitting by the Markdown descriptions.

```ruby
splitter = Baran::MarkdownSplitter.new
splitter.chunks(markdown)
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

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moekidev/baran. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/moekidev/baran/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Baran project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/moekidev/baran/blob/main/CODE_OF_CONDUCT.md).
