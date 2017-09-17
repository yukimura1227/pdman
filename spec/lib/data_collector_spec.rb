require 'rails_helper'

RSpec.describe DataCollector do
  describe '.extract_html_and_charset' do
    it 'can store monsters' do
      DataCollector.sample
      expect(Monster.find(10).name).to eq 'ブラッキオ'
      expect(Monster.count).to eq 100
    end
  end
end
