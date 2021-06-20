class CreatePlayer < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :external_url, null: false
      
      t.integer :jersey_number
      t.string :position
      
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
