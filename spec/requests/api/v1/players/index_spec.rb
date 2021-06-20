require 'rails_helper'

describe 'Players Index' do
    before :each do
        fixture_json = File.read('spec/fixtures/avs_with_roster.json')
        @stub_team_request = stub_request(:get, "https://statsapi.web.nhl.com/api/v1/teams/21/roster").
            to_return(status: 200, body: fixture_json)

        @avs = Team.create!(
            id: 21,
            name: "Colorado Avalanche",
            abbr: "COL",
            external_url: "https://statsapi.web.nhl.com/api/v1/teams/21",
        )
    end

    it "can get all the players on a team's roster (no filtering)" do
        get "/api/v1/teams/#{@avs.abbr}/players"

        players_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(players_json.count).to eq 3
        player_1_json = players_json[0]

        expect(player_1_json['id']).to be_a(Integer)
        expect(player_1_json['team_id']).to be_a(Integer)
        expect(player_1_json['first_name']).to be_a(String)
        expect(player_1_json['last_name']).to be_a(String)
        expect(player_1_json['external_url']).to be_a(String)
        expect(player_1_json['jersey_number']).to be_a(Integer)
        expect(player_1_json['position']).to be_a(String)
    end

    it "can sort results by first_name ASC and DESC" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'first_name_asc'}

        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["first_name"]).to eq "Cale"
        expect(player_2_json["first_name"]).to eq "Gabriel"
        expect(player_3_json["first_name"]).to eq "Nathan"

        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'first_name_desc'}
        
        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["first_name"]).to eq "Nathan"
        expect(player_2_json["first_name"]).to eq "Gabriel"
        expect(player_3_json["first_name"]).to eq "Cale"
    end

    it "can sort results by last_name ASC and DESC" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'last_name_asc'}

        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["last_name"]).to eq "Landeskog"
        expect(player_2_json["last_name"]).to eq "MacKinnon"
        expect(player_3_json["last_name"]).to eq "Makar"

        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'last_name_desc'}
        
        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["last_name"]).to eq "Makar"
        expect(player_2_json["last_name"]).to eq "MacKinnon"
        expect(player_3_json["last_name"]).to eq "Landeskog"
    end

    it "can sort results by jersey_number ASC and DESC" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'jersey_asc'}

        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["jersey_number"]).to eq 8
        expect(player_2_json["jersey_number"]).to eq 29
        expect(player_3_json["jersey_number"]).to eq 92

        get "/api/v1/teams/#{@avs.abbr}/players", params: {sort: 'jersey_desc'}
        
        players_json = JSON.parse(response.body)
        player_1_json, player_2_json, player_3_json = players_json

        expect(player_1_json["jersey_number"]).to eq 92
        expect(player_2_json["jersey_number"]).to eq 29
        expect(player_3_json["jersey_number"]).to eq 8
    end

    it "can filter by first_name" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {first_name: 'cale'}

        players_json = JSON.parse(response.body)
        expect(players_json.count).to eq 1
        expect(players_json[0]["first_name"]).to eq "Cale"
        expect(players_json[0]["last_name"]).to eq "Makar"
    end

    it "can filter by last_name" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {last_name: 'Mack'}

        players_json = JSON.parse(response.body)
        expect(players_json.count).to eq 1
        expect(players_json[0]["first_name"]).to eq "Nathan"
        expect(players_json[0]["last_name"]).to eq "MacKinnon"
    end

    it "can filter by position" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {position: 'C'}

        players_json = JSON.parse(response.body)
        expect(players_json.count).to eq 1
        expect(players_json[0]["first_name"]).to eq "Nathan"
        expect(players_json[0]["last_name"]).to eq "MacKinnon"
        expect(players_json[0]["position"]).to eq "C"

        # No goalies in the fixture data
        get "/api/v1/teams/#{@avs.abbr}/players", params: {position: 'G'}
        players_json = JSON.parse(response.body)
        expect(players_json).to eq []
    end

    it "can filter by jersey_number" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {jersey: 92}

        players_json = JSON.parse(response.body)
        expect(players_json.count).to eq 1
        expect(players_json[0]["last_name"]).to eq "Landeskog"
        expect(players_json[0]["jersey_number"]).to eq 92
    end
end