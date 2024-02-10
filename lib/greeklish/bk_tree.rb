# frozen_string_literal: true
# encoding: UTF-8

require_relative './node'

# BK-tree implementation
module Greeklish
  class BkTree
    attr_reader :root_node

    NUM_OF_MATCHES = 3

    def initialize
      @root_node = nil
    end

    def insert(word)
      if root_node
        root_node.insert(word)
      else
        @root_node = Node.new(word)
      end
    end

    def search(word)
      matches = root_node.search(word)
      if matches.values.min == 0
        exact_match(matches)
      else
        first_n_matches(matches)
      end
    end

    private

    def exact_match(matches)
      matches.find { |word, dist| word if dist == 0 }.first
    end

    def first_n_matches(matches)
      matches
        .sort_by { |_, dist| dist }
        .first(NUM_OF_MATCHES)
        .map { |w, _| w }
        .join('/')
    end
  end
end
