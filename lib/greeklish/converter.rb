# frozen_string_literal: true

require_relative "./latin_to_greek"

# Greek spell checking using BK-tree and Levenshtein distance algorithms
module Greeklish
  class Converter
    class << self
      def run(text, bk_tree)
        greek_text = LatinToGreek.convert(text)

        I18n.locale = :el
        split_text(greek_text)
          .map { |word| fuzzy_search(word, bk_tree) }
          .join(' ')
      end

      private

      def split_text(text)
        text.split(' ')
      end

      def fuzzy_search(word, bk_tree)
        bk_tree.search(remove_punctuation(word))
      end

      def remove_punctuation(word)
        word.gsub(/[^α-ωΑ-Ω]/, '')
      end
    end
  end
end
