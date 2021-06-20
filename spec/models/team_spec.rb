require "rails_helper"

describe Team, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)} 
    it {should validate_presence_of(:abbr)} 
    it {should validate_presence_of(:external_url)} 
    
    it {should_not validate_presence_of(:division)} 
    it {should_not validate_presence_of(:conference)} 
    it {should_not validate_presence_of(:inaugural_year)} 
  end

  describe "relationships" do
    it {should have_many(:players)}
  end
end