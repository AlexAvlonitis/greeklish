require 'spec_helper'
require 'greeklish/latin_to_greek'

describe Greeklish::LatinToGreek do
  context 'Convert latin text to greek' do
    [
      { text: 'pote tha kanei ksasteria', result: 'ποτε θα κανει ξαστερια' },
      { text: 'to paidi kai to delphini', result: 'το παιδι και το δελφινι' },
      {
        text: 'parakalw kante isihia, kounise ti ntoulapa',
        result: 'παρακαλω καντε ισιχια, κουνισε τι ντουλαπα'
      },
    ].each do |values|
      it 'converts successfully' do
        expect(described_class.convert(values[:text])).to eq(values[:result])
      end
    end
  end
end
