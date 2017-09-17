require 'rails_helper'

RSpec.describe Attribute, type: :model do
  describe 'Attribute records' do
    it do
      expect(described_class.pluck(:name)).to contain_exactly(
        '火', '水', '木', '光', '闇'
      )
    end
  end
end
