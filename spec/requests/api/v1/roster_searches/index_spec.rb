require 'rails_helper'

describe 'Searches Index' do
    it "can show all the current team and roster search data with frequencies" do
        search_1 = RosterSearch.create!(team_abbr: "MTL", jersey_number: 33, frequency: 4)
        search_2 = RosterSearch.create!(team_abbr: "COL", position: "D", frequency: 20)
        search_3 = RosterSearch.create!(team_abbr: "COL", first_name: "Mack", frequency: 8)
        
        get "/api/v1/roster_searches"
        
        roster_searches_json = JSON.parse(response.body)

        expect(roster_searches_json).to be_a Array
        expect(roster_searches_json.length).to eq 3
        expect(roster_searches_json[0]["team_abbr"]).to eq "COL"
        expect(roster_searches_json[0]["position"]).to eq "D"
        expect(roster_searches_json[0]["frequency"]).to eq 20
    end
end