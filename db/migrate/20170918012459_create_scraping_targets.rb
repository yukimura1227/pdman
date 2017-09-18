class CreateScrapingTargets < ActiveRecord::Migration[5.1]
  def change
    create_table :scraping_targets do |t|
      t.string :type, null: false
      t.string :url, null: false, index: true
      t.string :link_name
      t.datetime :last_scraping_at, null: false
      t.boolean :is_success_last
      t.text :log_message

      t.timestamps
    end
  end
end
