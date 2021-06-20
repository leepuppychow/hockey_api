class UniqueRosterSearch < ActiveRecord::Migration[6.1]
  def up
    change_column :roster_searches, :team_abbr, :citext
    change_column :roster_searches, :first_name, :citext
    change_column :roster_searches, :last_name, :citext
    change_column :roster_searches, :position, :citext
    add_index :roster_searches, [:team_abbr, :first_name, :last_name, :position], unique: true, name: "ix_unique_roster_search"
  end

  def down
    change_column :roster_searches, :team_abbr, :string
    change_column :roster_searches, :first_name, :string
    change_column :roster_searches, :last_name, :string
    change_column :roster_searches, :position, :string
    remove_index :roster_searches, name: "ix_unique_roster_search"
  end
end
