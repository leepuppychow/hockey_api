require 'rails_helper'

describe 'Searches Index' do
    it "can show all the current team and roster search data with frequencies" do
        avs = Team.create!(name: "Avs", abbr: "COL", external_url: "/avs")
        search_1 = RosterSearch.create!(team_abbr: "MTL", jersey_number: 33, frequency: 4)
        search_2 = RosterSearch.create!(team_abbr: "COL", first_name: "Mack", frequency: 8)
        search_3 = RosterSearch.create!(team_abbr: "COL", position: "D", frequency: 20)
        defenseman_1 = Player.create!(first_name: "Cale", last_name: "Makar", external_url: "/hi", team: avs)
        defenseman_2 = Player.create!(first_name: "Devon", last_name: "Toews", external_url: "/hi_there", team: avs)
        search_3.players = [defenseman_1, defenseman_2]
        
        get "/api/v1/roster_searches"
        
        roster_searches_json = JSON.parse(response.body)

        expect(roster_searches_json).to be_a Array
        expect(roster_searches_json.length).to eq 3
        expect(roster_searches_json[0]["team_abbr"]).to eq "COL"
        expect(roster_searches_json[0]["position"]).to eq "D"
        expect(roster_searches_json[0]["frequency"]).to eq 20

        expect(roster_searches_json[0]["players"]).to be_a Array
        expect(roster_searches_json[0]["players"][0]["last_name"]).to eq defenseman_1.last_name
        expect(roster_searches_json[0]["players"][1]["last_name"]).to eq defenseman_2.last_name

        expect(roster_searches_json[1]["players"]).to eq []
    end
end