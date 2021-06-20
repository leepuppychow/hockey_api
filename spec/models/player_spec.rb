require 'rails_helper'

describe Player, type: :model do
  describe "validations" do
    it {should validate_presence_of(:first_name)} 
    it {should validate_presence_of(:last_name)} 
    it {should validate_presence_of(:external_url)} 
    
    it {should_not validate_presence_of(:jersey_number)} 
    it {should_not validate_presence_of(:position)} 
  end

  describe "relationships" do 
    it {should belong_to(:team)}
  end
end