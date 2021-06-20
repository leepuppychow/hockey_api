require "rails_helper"

describe TeamSearch, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)} 
    it {should validate_presence_of(:frequency)}  
    it {should_not validate_presence_of(:abbr)} 
    it {should_not validate_presence_of(:division)} 
    it {should_not validate_presence_of(:conference)} 
  end
end