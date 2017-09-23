# 種族を表すモデル
class Species < ApplicationRecord
  has_many :monster_species
  has_many :monsters, through: :monster_species
end
