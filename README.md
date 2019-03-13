# Umwelt

Umwelt is a way to express domain knowledge in a figurable format.
It includes a language( collection of abstractions ),
[umwelt.dev](http://umwelt.dev) for collaborative domain development,
and this gem, as a tool for generate code structure and specs from umwelt.

The word `Umwelt` was borrowed from [Biosemiotics](https://en.wikipedia.org/wiki/Biosemiotics). In the semiotic theories of Jakob von Uexküll and Thomas A. Sebeok, umwelt (plural: umwelten; from the German Umwelt meaning "environment" or "surroundings") is the "biological foundations that lie at the very epicenter of the study of both communication and signification in the human [and non-human] animal".[1] The term is usually translated as "self-centered world".
So, in our case umwelt is the world how it sees for our apps.

At now, this is proof of concept and work still in progress.

## Installation

> Add this line to your application's Gemfile:

> ```ruby
> gem 'umwelt'
> ```

And then execute:

    $ git clone https://github.com/sovetnik/umwelt.git
    $ bundle
    $ bin/umwelt

> Or install it yourself as:

>     $ gem install umwelt

## Usage

Main executable is `umwelt`
```shell
 umwelt help
Commands:
  umwelt clone PROJECT/USERNAME               # Clone project from remote Umwelt
  umwelt convey PHASE SEMANTIC                # Convey Phase in Semantic from local Umwelt
  umwelt example                              # Create example Umwelt
  umwelt pull                                 # Pull project from remote Umwelt
  umwelt version
  ```

In 0.2 version only three command is implemented: `example`, `clone` and `convey`.

If you have project on [umwelt.dev](http://umwelt.dev), clone it and convey.
```shell
umwelt clone 'username/projectname'
```

If not, call `example`, it will copy source files in `./.umwelt`
```shell
umwelt example
```
This is main feature of gem, generate imprints of code and write it to files. Let's do this and see result.

```shell
umwelt convey 7 plain
ls -R umwelt 
```

After that you can see generated files.

```shell
Buildung phase: 7 with semantic plain...
...
10 files written succesfully
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sovetnik/umwelt. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Umwelt project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/umwelt/blob/master/CODE_OF_CONDUCT.md).
