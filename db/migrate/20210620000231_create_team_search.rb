class CreateTeamSearch < ActiveRecord::Migration[6.1]
  def change
    create_table :team_searches do |t|
      t.integer :frequency, null: false, default: 1
      t.string :name, null: false
      t.string :abbr
      t.string :division
      t.string :conference

      t.timestamps
    end
  end
end
