class TeamSearch < ApplicationRecord
  validates_presence_of :frequency
  validates_uniqueness_of :name, scope: [:abbr, :division, :conference], case_sensitive: false
end