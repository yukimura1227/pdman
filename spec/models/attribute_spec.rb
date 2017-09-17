require 'rails_helper'

RSpec.describe Attribute, type: :model do
  describe 'recrods size' do
    it 'is 5(火,水,木,光,闇)' do
      expect(Attribute.pluck(:name)).to contain_exactly('火', '水', '木', '光', '闇')
    end
  end
end
