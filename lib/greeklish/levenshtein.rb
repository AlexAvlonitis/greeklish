# frozen_string_literal: true
# encoding: UTF-8

require 'pry'

# Calculate the edit distance between two strings
# Using the Levenshtein algorithm
module Greeklish
  class Levenshtein
    class << self
      def distance(from_word, to_word)
        transliterate_words(from_word, to_word)
        build_dp_matrix

        (1...column_size).each do |col_index|
          (1...row_size).each do |row_index|
            populate_dp_matrix(col_index, row_index)
          end
        end

        # bottom right/last cell is the result of the distance value
        @dp_matrix[@from_word.size][@to_word.size]
      end

      private

      # Converts greek text back to latin for mode accurate comparison
      # removing hyphenantions e.g ά -> a
      def transliterate_words(from_word, to_word)
        @from_word = I18n.transliterate(from_word)
        @to_word = I18n.transliterate(to_word)
      end

      # Create a 2 dimensional table with a row length equal to the second word
      # and column size equal to the first.
      def build_dp_matrix
        @dp_matrix = Array.new(column_size) { Array.new(row_size) }

        # populate first row with the word's letters
        row_size.times { |n| @dp_matrix[0][n] = n }

        # populate first column with the word's letters
        column_size.times { |n| @dp_matrix[n][0] = n }
      end

      def column_size
        @from_word.size + 1
      end

      def row_size
        @to_word.size + 1
      end

      # Compares each letter of each word one by one, each row with the
      # corresponding column. To populate a cell it follows the algorithm:
      # If the letters match up from the matrix then it fills it in with the value
      # of the diagonal top left cell, otherwise it fills it in with the minimum
      # value of between the left, up and diagonal top left value + 1
      def populate_dp_matrix(col_index, row_index)
        up = col_index - 1
        left = row_index - 1

        replace_value = @dp_matrix[up][left]
        insert_value = @dp_matrix[col_index][left]
        remove_value = @dp_matrix[up][row_index]

        same_letter = @from_word[col_index -1] == @to_word[row_index -1]
        return @dp_matrix[col_index][row_index] = replace_value if same_letter

        min_value = [replace_value, insert_value, remove_value].min
        @dp_matrix[col_index][row_index] = min_value + 1
      end
    end
  end
end
