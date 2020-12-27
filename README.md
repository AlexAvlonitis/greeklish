# Greeklish

Converts greeklish i.e 'ti kanete' to greek 'τι κάνετε'. This project is for educational
purposes only, not meant for production environments. Practised the Levenshtein algorithm for the edit distance between words and BK-Tree to construct a tree based on the words' distance in ruby.


### **High level Algorithm explanation**

`> Convert greeklish to greek`

`>> Build BK tree out of the greek dictionary`

On first run it builds the BK-tree out of a 500_000 word greek dictionary and stores it in memory, it will build a bk_tree.yml file so the next time it will boot up significally faster.

**Useful links:**

[What is a bk-tree](https://www.youtube.com/watch?v=oIsPB2pqq_8)

[Understanding Levenshtein edit distance (article)](https://medium.com/@ethannam/understanding-the-levenshtein-distance-equation-for-beginners-c4285a5604f0)

[Understanding Levenshtein edit distance (video)](https://www.youtube.com/watch?v=b6AGUjqIPsA)

`>> One to one mapping latin to greek conversion`

This is nothing but a one to one mapping of each latin letter into its greek equivalent, specified by the en.yml file with only few special cases of diphthongs.

`>> Greek aproximate spell checking`

For each word it parses the bk-tree and transforms it to the closest word it finds, specified by the DIST_THRESHOLD with default value 1. Meaning it will either return exact matches of 0 distance or the first 3 matches with distance 1 i.e: "αυτό/αυγό/αργό".


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'greeklish'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install greeklish

## Usage

```ruby
require 'greeklish'

Greeklish.convert('ti kaneis')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexavlonitis/greeklish.
