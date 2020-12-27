# frozen_string_literal: true

require "greeklish/latin_to_greek"

# Greek spell checking using BK-tree and Levenshtein distance algorithms
module Greeklish
  class Converter
    class << self
      def run(text, bk_tree)
        greek_text = LatinToGreek.convert(text)

        I18n.locale = :el
        greek_text.split(' ').map { |word| bk_tree.search(word) }.join(' ')
      end
    end
  end
end
