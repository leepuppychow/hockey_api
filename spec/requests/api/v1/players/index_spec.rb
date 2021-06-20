require 'rails_helper'

describe 'Players Index' do
    before :each do
        fixture_json = File.read('spec/fixtures/avs_with_roster.json')
        @stub_team_request = stub_request(:get, "https://statsapi.web.nhl.com/api/v1/teams/21/roster").
            to_return(status: 200, body: fixture_json)
    end

    it "can get all the players on a team's roster (no filtering)" do
        avs = Team.create!(
            id: 21,
            name: "Colorado Avalanche",
            abbr: "COL",
            external_url: "https://statsapi.web.nhl.com/api/v1/teams/21",
        )

        get "/api/v1/teams/#{avs.abbr}/players"

        players_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(players_json.count).to eq 34
        player_1_json = players_json[0]

        expect(player_1_json['id']).to be_a(Integer)
        expect(player_1_json['team_id']).to be_a(Integer)
        expect(player_1_json['first_name']).to be_a(String)
        expect(player_1_json['last_name']).to be_a(String)
        expect(player_1_json['external_url']).to be_a(String)
        expect(player_1_json['jersey_number']).to be_a(Integer)
        expect(player_1_json['position']).to be_a(String)
    end

end