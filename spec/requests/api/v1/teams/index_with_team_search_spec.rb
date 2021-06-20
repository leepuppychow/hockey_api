require 'rails_helper'

describe "Teams Index endpoint upserts TeamSearch records" do
    before :each do
        fixture_json = File.read('spec/fixtures/teams_no_roster.json')
        @stub_team_request = stub_request(:get, "https://statsapi.web.nhl.com/api/v1/teams").
            to_return(status: 200, body: fixture_json)
    end

    it "can filter results by query params and create a unique TeamSearch record" do
        get "/api/v1/teams", params: {name: 'Colorado Avalanche', conference: 'west'}

        teams_json = JSON.parse(response.body)
        expect(teams_json.count).to eq 1
        team_1_json = teams_json[0]
        expect(team_1_json["name"]).to eq "Colorado Avalanche"

        team_searches = TeamSearch.all
        search_1 = team_searches[0]

        expect(team_searches.length).to eq 1
        expect(search_1.name).to eq 'Colorado Avalanche'
        expect(search_1.conference).to eq 'west'
        expect(search_1.frequency).to eq 1

        # If the same request is made again, frequency for that TeamSearch should be incremented:

        get "/api/v1/teams", params: {name: 'colorado avalanche', conference: 'WEST'} # Note case insensitivity
        team_searches = TeamSearch.all
        search_1 = team_searches[0]

        expect(team_searches.length).to eq 1
        expect(search_1.name).to eq 'Colorado Avalanche'
        expect(search_1.frequency).to eq 2

        get "/api/v1/teams", params: {division: 'WEST'}
        team_searches = TeamSearch.all
        search_1, search_2 = team_searches
        expect(search_1.frequency).to eq 2
        expect(search_2.frequency).to eq 1

        # With no query params, the TeamSearch table should be left alone:
        get "/api/v1/teams"
        team_searches = TeamSearch.all
        search_1, search_2 = team_searches
        expect(search_1.frequency).to eq 2
        expect(search_2.frequency).to eq 1
    end
end