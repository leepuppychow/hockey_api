class CreateRosterSearch < ActiveRecord::Migration[6.1]
  def change
    create_table :roster_searches do |t|
      t.integer :frequency, null: false, default: 1
      t.string :team_abbr, null: false
      t.string :full_name
      t.string :position
      t.integer :jersey_number

      t.timestamps
    end
  end
end
