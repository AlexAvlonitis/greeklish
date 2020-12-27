# frozen_string_literal: true
# encoding: UTF-8

require 'greeklish/bk_tree'

# BK-tree implementation
module Greeklish
  class BkTreeBuilder
    attr_reader :root_node

    YAML_FILE = 'bk_tree.yml'

    def self.build
      file = File.read('greek.dic', encoding: 'utf-8')
      new(file, BkTree.new).build
    end

    def initialize(file, bk_tree)
      @words = file.split("\n")
      @bk_tree = bk_tree
    end

    def build
      puts "Building dictionary please wait..."
      return bk_tree_import if File.file?(YAML_FILE) # delete the file to recompute a new dictionary

      words.each do |word|
        puts "adding #{word}"
        bk_tree.insert(word)
      end

      bk_tree_export
      return_tree
    end

    private

    attr_reader :words, :bk_tree

    def bk_tree_export
      File.write(YAML_FILE, YAML.dump(bk_tree))
    end

    def bk_tree_import
      @bk_tree = YAML.load(File.read(YAML_FILE))
      return_tree
    end

    def return_tree
      puts "Dictionary is ready!"
      bk_tree
    end
  end
end
