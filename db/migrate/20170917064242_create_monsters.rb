class CreateMonsters < ActiveRecord::Migration[5.1]
  def change
    create_table :monsters do |t|
      t.integer :uid, null: false
      t.integer :element_id, null: false
      t.integer :sub_element_id
      t.integer :monster_species_id, null: false
      t.references :skill, index: true

      t.timestamps
    end
  end
end
