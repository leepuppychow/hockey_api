class TeamSearch < ApplicationRecord
  validates_presence_of :frequency
  validates_uniqueness_of :name, scope: [:abbr, :division, :conference], case_sensitive: false

  has_many :team_search_teams
  has_many :teams, through: :team_search_teams
end