require 'rails_helper'

describe 'Searches Index' do
    it "can show all the current team and roster search data with frequencies" do
        search_1 = TeamSearch.create!(division: "north", name: "leafs", frequency: 1)
        search_2 = TeamSearch.create!(division: "west", frequency: 5)
        west_team_1 = Team.create!(name: "Colorado Avalanche", abbr: "COL", external_url: "hi")
        west_team_2 = Team.create!(name: "Los Angeles Kings", abbr: "LAK", external_url: "hi_there")
        search_2.teams = [west_team_1, west_team_2]
        
        get "/api/v1/team_searches"
        
        team_searches_json = JSON.parse(response.body)

        expect(team_searches_json).to be_a Array
        expect(team_searches_json.length).to eq 2
        expect(team_searches_json[0]["division"]).to eq "west"
        expect(team_searches_json[0]["frequency"]).to eq 5
        expect(team_searches_json[0]["teams"]).to be_a Array
        expect(team_searches_json[0]["teams"].count).to eq 2
        
        expect(team_searches_json[1]["teams"].count).to eq 0
    end
end