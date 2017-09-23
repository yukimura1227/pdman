require 'rails_helper'

RSpec.describe Skill, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:monsters) }
  end
end
