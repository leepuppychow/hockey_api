class TeamSearchTeam < ApplicationRecord
    belongs_to :team
    belongs_to :team_search
end