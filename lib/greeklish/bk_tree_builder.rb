# frozen_string_literal: true
# encoding: UTF-8

require_relative './bk_tree'

# BK-tree implementation
module Greeklish
  class BkTreeBuilder
    YAML_FILE = 'bk_tree.yml'

    def self.build
      file = File.read('greek.dic', encoding: 'utf-8')
      new(file, BkTree.new).build
    end

    def initialize(file, bk_tree)
      @file = file
      @bk_tree = bk_tree
    end

    def build
      puts "Building dictionary please wait..."
      return load_bk_tree_to_memory_from_file if File.file?(YAML_FILE) # delete the file to recompute a new dictionary

      build_bk_tree
      write_bk_tree_to_file
      load_bk_tree_to_memory_from_file
    end

    private

    attr_reader :file, :bk_tree

    def build_bk_tree
      split_each_line_from_file.each { |word| bk_tree.insert(word) }
    end

    def split_each_line_from_file
      file.split("\n")
    end

    def write_bk_tree_to_file
      File.write(YAML_FILE, YAML.dump(bk_tree))
    end

    def load_bk_tree_to_memory_from_file
      @bk_tree = YAML.safe_load(
        File.read(YAML_FILE),
        permitted_classes: [Greeklish::BkTree, Greeklish::Node]
      )
      puts "Dictionary is ready!"
      bk_tree
    end
  end
end
