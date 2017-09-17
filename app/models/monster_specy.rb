class MonsterSpecy < ApplicationRecord
  belongs_to :monster_id
  belongs_to :species
end
