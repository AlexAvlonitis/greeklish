# encoding: UTF-8

require 'spec_helper'
require 'greeklish/bk_tree'

describe Greeklish::BkTree do
  let(:file) { File.read('spec/fixtures/sample.dic') }
  let(:subject) { described_class.new }

  before { file.each_line.each { |w| subject.insert(w.chomp) } }

  context 'builds a bk tree' do
    it 'returns the correctly constructed tree' do
      root_node = subject.root_node

      expect(root_node.to_s).to eq 'αέρας'
      expect(root_node.children[2].to_s).to eq 'αέριο'
      expect(root_node.children[2].children[1].to_s).to eq 'αέριος'
      expect(root_node.children[3].to_s).to eq 'αλέξης'
      expect(root_node.children[6].to_s).to eq 'βιβλίο'
      expect(root_node.children[6].children[1].to_s).to eq 'βιβλία'
    end
  end

  context '.search' do
    [
      { input: 'αέρασ', expected: 'αέρας' },
      { input: 'αέριο', expected: 'αέριο' },
      { input: 'αλέξις', expected: 'αλέξης' },
      { input: 'βιβλια', expected: 'βιβλία' }
    ].each do |values|
      it 'finds the closest word' do
        expect(subject.search(values[:input])).to eq values[:expected]
      end
    end
  end
end
