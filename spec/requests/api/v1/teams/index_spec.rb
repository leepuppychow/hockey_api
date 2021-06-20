require 'rails_helper'

describe "Teams Index" do
    before :each do
        fixture_json = File.read('spec/fixtures/teams_no_roster.json')
        @stub_team_request = stub_request(:get, "https://statsapi.web.nhl.com/api/v1/teams").
            to_return(status: 200, body: fixture_json)
    end

    it "can get all existing teams without roster data" do
        get "/api/v1/teams"

        teams_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(teams_json.count).to eq 3
        team_1_json = teams_json[0]
        expect(team_1_json['id']).to be_a(Integer)
        expect(team_1_json['name']).to be_a(String)
        expect(team_1_json['abbr']).to be_a(String)
        expect(team_1_json['external_url']).to be_a(String)
        expect(team_1_json['division']).to be_a(String)
        expect(team_1_json['conference']).to be_a(String)
        expect(team_1_json['inaugural_year']).to be_a(Integer)
    end

    it "upsert Team records when index endpoint is accessed" do
        get "/api/v1/teams"
        expect(Team.count).to eq 3

        get "/api/v1/teams"
        expect(Team.count).to eq 3
    end
end