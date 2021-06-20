require "rails_helper"

describe RosterSearch, type: :model do
  describe "validations" do
    it {should validate_presence_of(:team_abbr)}
    it {should validate_presence_of(:frequency)}
    
    it {should_not validate_presence_of(:first_name)}
    it {should_not validate_presence_of(:last_name)}
    it {should_not validate_presence_of(:position)}
    it {should_not validate_presence_of(:jersey_number)}
    
    subject {RosterSearch.new(team_abbr: "COL", position: 'C')}
    it {should validate_uniqueness_of(:team_abbr).scoped_to(:first_name, :last_name, :position, :jersey_number).case_insensitive}
    
    it "cannot create RosterSearch with duplicate search terms (case insensitive)" do
      search_1 = RosterSearch.create(team_abbr: 'COL', last_name: 'Mack')
      search_2 = RosterSearch.create(team_abbr: 'col', last_name: 'MACK')

      expect(search_1.save).to be(true) 
      expect(search_2.save).to be(false) 
    end
  end
end