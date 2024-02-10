# frozen_string_literal: true
# encoding: UTF-8

require_relative './levenshtein'

# BK-tree implementation
module Greeklish
  class Node
    attr_reader :children

    DIST_THRESHOLD = 1

    def initialize(value)
      @value = value
      @children = {}
    end

    def to_s
      value
    end

    def insert(word)
      edit_distance = edit_distance(word)

      if child_node = children[edit_distance]
        child_node.insert(word)
      else
        children[edit_distance] = self.class.new(word)
      end
    end

    def search(word, matches = {})
      edit_distance = edit_distance(word)
      matches[self.to_s] = edit_distance if edit_distance <= DIST_THRESHOLD

      search_children(edit_distance, word, matches)

      matches
    end

    private

    attr_reader :value

    def edit_distance(word)
      Levenshtein.distance(word, self.to_s)
    end

    def search_children(edit_distance, word, matches)
      ((edit_distance - DIST_THRESHOLD)..(edit_distance + DIST_THRESHOLD)).each do |score|
        child_node = children[score]
        child_node.search(word, matches) if child_node
      end
    end
  end
end
