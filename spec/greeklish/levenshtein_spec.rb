require 'spec_helper'
require 'greeklish/levenshtein'

describe Greeklish::Levenshtein do
  context 'calculates the edit distance between 2 strings' do
    [
      { from: 'cat', to: 'cats', distance: 1 },
      { from: 'kite', to: 'kitten', distance: 2 },
      { from: 'honda', to: 'hyundai', distance: 3 },
      { from: 'cat', to: 'dog', distance: 3 },
      { from: 'rose', to: 'horse', distance: 2 },
      { from: 'a', to: 'b', distance: 1 },
      { from: 'αέριo', to: 'αέριo', distance: 0 },
      { from: 'cat', to: 'cat', distance: 0 },
      { from: 'ελληνικά', to: 'ελληνικός', distance: 2 }
    ].each do |values|
      it 'returns the correct edit distance' do
        I18n.locale = :el

        expect(described_class.distance(values[:from], values[:to]))
          .to eq(values[:distance])
      end
    end
  end
end
