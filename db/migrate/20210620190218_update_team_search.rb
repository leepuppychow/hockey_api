class UpdateTeamSearch < ActiveRecord::Migration[6.1]
  def up
    change_column :team_searches, :name, :citext, :null => true
    change_column :team_searches, :abbr, :citext
    change_column :team_searches, :division, :citext
    change_column :team_searches, :conference, :citext
    add_index :team_searches, [:name, :abbr, :division, :conference], unique: true, name: "ix_unique_team_search"
  end

  def down
    change_column :team_searches, :name, :string, :null => false
    change_column :team_searches, :abbr, :string
    change_column :team_searches, :division, :string
    change_column :team_searches, :conference, :string
    remove_index :team_searches, name: "ix_unique_team_search"
  end
end
