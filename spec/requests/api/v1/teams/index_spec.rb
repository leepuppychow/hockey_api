require 'rails_helper'

describe "Teams Index" do
    it "can get all existing teams without roster data" do
        get "/api/v1/teams"

        teams_json = JSON.parse(response.body)

        expect(response.status).to eq 200
        expect(teams_json.count).to eq 32
        team_1_json = teams_json[0]
        expect(team_1_json['id']).to be_a(Integer)
        expect(team_1_json['name']).to be_a(String)
        expect(team_1_json['abbr']).to be_a(String)
        expect(team_1_json['external_url']).to be_a(String)
        expect(team_1_json['division']).to be_a(String)
        expect(team_1_json['conference']).to be_a(String)
        expect(team_1_json['inaugural_year']).to be_a(Integer)
    end
end