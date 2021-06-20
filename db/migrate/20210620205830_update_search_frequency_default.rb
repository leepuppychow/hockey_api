class UpdateSearchFrequencyDefault < ActiveRecord::Migration[6.1]
  def up
    change_column :team_searches, :frequency, :integer, :default => 0
    change_column :roster_searches, :frequency, :integer, :default => 0
  end

  def down
    change_column :team_searches, :frequency, :integer, :default => 1
    change_column :roster_searches, :frequency, :integer, :default => 1
  end
end
