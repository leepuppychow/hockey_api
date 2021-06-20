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

    it "can filter results by query params and create a unique RosterSearch record" do
        get "/api/v1/teams/#{@avs.abbr}/players", params: {first_name: 'cale', position: 'D'}

        players_json = JSON.parse(response.body)
        expect(players_json.count).to eq 1
        expect(players_json[0]["first_name"]).to eq "Cale"
        expect(players_json[0]["last_name"]).to eq "Makar"

        roster_searches = RosterSearch.all
        search_1 = roster_searches[0]

        expect(search_1.team_abbr).to eq 'COL'
        expect(search_1.first_name).to eq 'cale'
        expect(search_1.position).to eq 'D'
        expect(search_1.frequency).to eq 1

        # If the same request is made again, frequency for that RosterSearch should be incremented:
        get "/api/v1/teams/#{@avs.abbr}/players", params: {first_name: 'CALE', position: 'd'}
        roster_searches = RosterSearch.all
        search_1 = roster_searches[0]
        expect(search_1.frequency).to eq 2

        get "/api/v1/teams/#{@avs.abbr}/players", params: {position: 'D'}
        roster_searches = RosterSearch.all
        search_1, search_2 = roster_searches
        expect(search_1.frequency).to eq 2
        expect(search_2.frequency).to eq 1

        # With no query params, the RosterSearch table should be left alone:
        get "/api/v1/teams/#{@avs.abbr}/players"
        roster_searches = RosterSearch.all
        search_1, search_2 = roster_searches
        expect(search_1.frequency).to eq 2
        expect(search_2.frequency).to eq 1
    end
end