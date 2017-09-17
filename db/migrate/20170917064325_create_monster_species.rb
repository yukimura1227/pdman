class CreateMonsterSpecies < ActiveRecord::Migration[5.1]
  def change
    create_table :monster_species do |t|
      t.references :monster_id, index: true
      t.references :species, index: true

      t.timestamps
    end
  end
end
