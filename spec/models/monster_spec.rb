require 'rails_helper'

RSpec.describe Monster, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:skill) }
    it { is_expected.to belong_to(:element).class_name('Attribute') }
    it { is_expected.to belong_to(:sub_element).class_name('Attribute') }
  end
end
