# frozen_string_literal: true
# encoding: UTF-8

require 'greeklish/node'
require 'pry'

# BK-tree implementation
module Greeklish
  class BkTree
    attr_reader :root_node

    def initialize(node_klass = Node)
      @node_klass = node_klass
      @root_node = nil
    end

    def insert(word)
      if root_node
        root_node.insert(word)
      else
        @root_node = node_klass.new(word)
      end
    end

    def search(word)
      matches = root_node.search(word)
      if matches.values.min == 0
        exact_match(matches)
      else
        first_n_matches(matches, 3)
      end
    end

    private

    attr_reader :node_klass

    def exact_match(matches)
      matches.find { |word, dist| word if dist == 0 }.first
    end

    def first_n_matches(matches, num)
      matches
        .sort_by { |word, dist| dist }
        .first(num)
        .map { |w, dist| w }
        .join('/')
    end
  end
end
