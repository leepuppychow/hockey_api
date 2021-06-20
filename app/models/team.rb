class Team < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :abbr
  validates_presence_of :external_url

  has_many :players
end