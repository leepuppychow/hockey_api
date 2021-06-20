class CreateTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :abbr, null: false
      t.string :external_url, null: false
      t.string :division
      t.string :conference
      t.integer :inaugural_year

      t.timestamps
    end
  end
end
