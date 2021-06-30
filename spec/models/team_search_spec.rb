require "rails_helper"

describe TeamSearch, type: :model do
  describe "validations" do
    it {should validate_presence_of(:frequency)}

    it {should_not validate_presence_of(:name)} 
    it {should_not validate_presence_of(:abbr)} 
    it {should_not validate_presence_of(:division)} 
    it {should_not validate_presence_of(:conference)}

    subject {TeamSearch.new(name: "Avs", abbr: "COL", division: 'west')}
    it {should validate_uniqueness_of(:name).scoped_to(:abbr, :division, :conference).case_insensitive}

    it "cannot create TeamSearch with duplicate search terms (case insensitive)" do
      search_1 = TeamSearch.create(abbr: 'COL', division: 'WEST')
      search_2 = TeamSearch.create(abbr: 'col', division: 'west')
      search_3 = TeamSearch.create(name: 'aval', conference: 'west')
      search_4 = TeamSearch.create(name: 'aval', conference: 'WEST')

      expect(search_1.save).to be(true) 
      expect(search_2.save).to be(false) 
      expect(search_3.save).to be(true) 
      expect(search_4.save).to be(false) 
    end
  end

  describe "Relationships" do
    it {should have_many(:teams).through(:team_search_teams)}
  end
end