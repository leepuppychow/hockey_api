class RosterSearch < ApplicationRecord
  validates_presence_of :team_abbr
  validates_presence_of :frequency
  validates_uniqueness_of :team_abbr, scope: [:first_name, :last_name, :position, :jersey_number], case_sensitive: false
end 