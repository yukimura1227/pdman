# モンスターの情報を管理するモデル
class Monster < ApplicationRecord
  belongs_to :skill
  with_options class_name: 'Attribute' do
    belongs_to :element, foreign_key: :element_id
    belongs_to :sub_element, foreign_key: :sub_element_id
  end
  has_many :monster_species
  has_many :species, through: :monster_species
end
