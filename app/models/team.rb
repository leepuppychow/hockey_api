class Team < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :abbr
  validates_presence_of :external_url
  validates_uniqueness_of :abbr

  has_many :players
end