class RosterSearch < ApplicationRecord
  validates_presence_of :team_abbr
  validates_presence_of :frequency
end 