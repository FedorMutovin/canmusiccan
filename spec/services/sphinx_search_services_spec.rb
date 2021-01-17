require 'rails_helper'

RSpec.describe SphinxSearch do
  describe '#search_results' do
    let!(:search_text) { 'some text' }

    it 'returns results for All' do
      expect(ThinkingSphinx).to receive(:search).with(search_text)
      described_class.search_results(search_text)
    end
  end
end
