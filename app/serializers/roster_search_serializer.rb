class RosterSearchSerializer < ActiveModel::Serializer
    attributes :id, :frequency, :team_abbr, :position, :jersey_number, :first_name, :last_name
    has_many :players, through: :roster_search_players
end
  