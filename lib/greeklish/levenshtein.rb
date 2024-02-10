# frozen_string_literal: true

# Calculate the edit distance between two strings
# Using the Levenshtein algorithm
module Greeklish
  class Levenshtein
    class << self
      def distance(from_word, to_word)
        from_word = transliterate_word(from_word)
        to_word = transliterate_word(to_word)

        col_size = dimensions(from_word)
        row_size = dimensions(to_word)

        matrix = build_matrix(col_size, row_size)
        populate_matrix(matrix, col_size, row_size, from_word, to_word)

        edit_distance_result(matrix, from_word, to_word)
      end

      private

      # remove hyphenantions e.g ά -> α, to save 1 edit distance point
      def transliterate_word(word)
        I18n.transliterate(word)
      end

      # Create a 2 dimensional matrix with the given dimensions
      # and populate the first row and column with the initial edit distance values
      def build_matrix(col_size, row_size)
        matrix = Array.new(col_size) { Array.new(row_size) }

        build_initial_row(row_size, matrix)
        build_initial_column(col_size, matrix)

        matrix
      end

      # populate first row with the initial edit distance values (0, 1, 2, 3, ...)
      def build_initial_row(row_size, matrix)
        row_size.times { |n| matrix[0][n] = n }
      end

      # populate first column with the initial edit distance values (0, 1, 2, 3, ...)
      def build_initial_column(col_size, matrix)
        col_size.times { |n| matrix[n][0] = n }
      end
      
      # The dimensions of the matrix are the length of the word + 1
      def dimensions(word)
        word.size + 1
      end

      # populate the matrix with the edit distance values
      def populate_matrix(matrix, col_size, row_size, from_word, to_word)
        (1...col_size).each do |col_index|
          (1...row_size).each do |row_index|
            calculate_distance_for_cell(col_index, row_index, matrix, from_word, to_word)
          end
        end
      end

      # Levenshtein algorithm implementation using dynamic programming.
      def calculate_distance_for_cell(col_index, row_index, matrix, from_word, to_word)
        up = col_index - 1
        left = row_index - 1

        replace_value = matrix[up][left]
        insert_value = matrix[col_index][left]
        remove_value = matrix[up][row_index]

        same_letter = from_word[col_index - 1] == to_word[row_index - 1]
        return matrix[col_index][row_index] = replace_value if same_letter

        min_value = [replace_value, insert_value, remove_value].min
        matrix[col_index][row_index] = min_value + 1
      end

      # bottom right/last cell is the result of the distance value
      def edit_distance_result(matrix, from_word, to_word)
        matrix[from_word.size][to_word.size]
      end
    end
  end
end
