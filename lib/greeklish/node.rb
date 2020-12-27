# frozen_string_literal: true
# encoding: UTF-8

require 'greeklish/levenshtein'
require 'pry'

# BK-tree implementation
module Greeklish
  class Node
    attr_reader :children

    DIST_THRESHOLD = 1

    def initialize(value, levenshtein_klass = Levenshtein)
      @value = value
      @children = {}
      @levenshtein_klass = levenshtein_klass
    end

    def to_s
      value
    end

    def insert(word)
      distance = distance(word)

      if child_node = children[distance]
        child_node.insert(word)
      else
        children[distance] = self.class.new(word)
      end
    end

    def search(word, matches = {})
      distance = distance(word)
      matches[self.to_s] = distance if distance <= DIST_THRESHOLD

      ((distance - DIST_THRESHOLD)..(distance + DIST_THRESHOLD)).each do |score|
        child_node = children[score]
        child_node.search(word, matches) if child_node
      end

      matches
    end

    private

    attr_reader :value, :levenshtein_klass

    def distance(word)
      levenshtein_klass.distance(word, self.to_s)
    end
  end
end
