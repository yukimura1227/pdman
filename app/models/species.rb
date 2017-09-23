# 種族を表すモデル
class Species < ApplicationRecord
  has_many :monster_species
end
