require 'rails_helper'

describe 'Searches Index' do
    it "can show all the current team and roster search data with frequencies" do
        search_1 = TeamSearch.create!(division: "north", name: "leafs", frequency: 1)
        search_2 = TeamSearch.create!(division: "west", frequency: 5)
        
        get "/api/v1/team_searches"
        
        team_searches_json = JSON.parse(response.body)

        expect(team_searches_json).to be_a Array
        expect(team_searches_json.length).to eq 2
        expect(team_searches_json[0]["division"]).to eq "west"
        expect(team_searches_json[0]["frequency"]).to eq 5
    end
end