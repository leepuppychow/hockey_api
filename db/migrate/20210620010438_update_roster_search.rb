class UpdateRosterSearch < ActiveRecord::Migration[6.1]
  def change
    remove_column :roster_searches, :full_name, :string
    
    add_column :roster_searches, :first_name, :string
    add_column :roster_searches, :last_name, :string
  end
end
