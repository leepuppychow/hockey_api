class RosterSearchPlayer < ApplicationRecord
    belongs_to :player
    belongs_to :roster_search
end