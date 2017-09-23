require 'rails_helper'

RSpec.describe Species, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:monster_species) }
    it { is_expected.to have_many(:monsters).through(:monster_species) }
  end
  describe 'Attribute records' do
    it do
      expect(described_class.pluck(:name)).to contain_exactly(
        '神', 'ドラゴン', '悪魔', 'マシン',
        'バランス', '攻撃', '体力', '回復',
        '進化', '覚醒', '強化合成用', '売却用'
      )
    end
  end
end
