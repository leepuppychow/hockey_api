class CreateTeamSearchTeam < ActiveRecord::Migration[6.1]
  def change
    create_table :team_search_teams do |t|
      t.references :team, null: true, foreign_key: true
      t.references :team_search, null: false, foreign_key: true

      t.timestamps
    end
  end
end
