# frozen_string_literal: true

# One to one mapping of latin characters to greek
module Greeklish
  class LatinToGreek
    class << self
      def convert(text)
        I18n.locale = :en
        text_to_letters = text.split('')

        diphthong = false
        text_to_letters.map.with_index do |letter, index|
          next_letter = text_to_letters[index + 1]

          if diphthong == true
            diphthong = false
            next
          end

          if dipht = diphthong(letter, next_letter)
            letter = dipht
            diphthong = true
          end

          translate(letter)
        end.join
      end

      private

      def diphthong(letter, next_letter)
        return 'th' if letter == 't' && next_letter == 'h'
        return 'ks' if letter == 'k' && next_letter == 's'
        return 'ph' if letter == 'p' && next_letter == 'h'
      end

      def translate(letter)
        I18n.t!(letter)
      rescue I18n::MissingTranslationData
        letter
      end
    end
  end
end
