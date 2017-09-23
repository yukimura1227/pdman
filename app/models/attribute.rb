# 属性を表すモデル
class Attribute < ApplicationRecord
  has_many :monsters, foreign_key: :element_id
end
