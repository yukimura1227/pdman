# モンスターの種族を表す中間モデル
class MonsterSpecy < ApplicationRecord
  belongs_to :monster
  belongs_to :species
end
