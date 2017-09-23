# 属性を表すモデル
class Attribute < ApplicationRecord
  with_options class_name: 'Monster' do
    has_many :monsters, foreign_key: :element_id
    has_many :monsters_by_sub_attribute, foreign_key: :sub_element_id
  end
end
