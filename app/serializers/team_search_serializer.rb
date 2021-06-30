class TeamSearchSerializer < ActiveModel::Serializer
    attributes :id, :frequency, :name, :abbr, :division, :conference
    has_many :teams, through: :team_search_teams
end
  