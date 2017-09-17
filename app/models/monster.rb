class Monster < ApplicationRecord
  belongs_to :skill
  with_options class_name: 'Attribute' do
    belongs_to :element, foreign_key: :element_id
    belongs_to :sub_element, foreign_key: :sub_element_id
  end
end
