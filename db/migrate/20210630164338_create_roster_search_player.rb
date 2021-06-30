class CreateRosterSearchPlayer < ActiveRecord::Migration[6.1]
  def change
    create_table :roster_search_players do |t|
      t.references :player, null: true, foreign_key: true
      t.references :roster_search, null: false, foreign_key: true

      t.timestamps
    end
  end
end
