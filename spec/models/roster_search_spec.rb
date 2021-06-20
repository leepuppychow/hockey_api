require "rails_helper"

describe RosterSearch, type: :model do
  describe "validations" do
    it {should validate_presence_of(:team_abbr)}
    it {should validate_presence_of(:frequency)}
    
    it {should_not validate_presence_of(:full_name)}
    it {should_not validate_presence_of(:position)}
    it {should_not validate_presence_of(:jersey_number)}
  end
end