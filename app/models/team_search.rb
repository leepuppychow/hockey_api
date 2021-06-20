class TeamSearch < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :frequency
end