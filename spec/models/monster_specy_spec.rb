require 'rails_helper'

RSpec.describe MonsterSpecy, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:monster) }
    it { is_expected.to belong_to(:species) }
  end
end
