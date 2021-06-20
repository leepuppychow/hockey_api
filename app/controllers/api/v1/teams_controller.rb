class Api::V1::TeamsController < ApplicationController
    def index
        base_url = "https://statsapi.web.nhl.com"
        conn = Faraday.new(url: base_url)
        response = conn.get("/api/v1/teams")
        json = JSON.parse(response.body, symbolize_names: true)
        teams = json[:teams].map do |team_json|
            team = Team.create(
                id: team_json[:id],
                name: team_json[:name],
                abbr: team_json[:abbreviation],
                external_url: base_url + team_json[:link],
                division: team_json[:division][:name],
                conference: team_json[:conference][:name],
                inaugural_year: team_json[:firstYearOfPlay],
            )
        end
        render json: teams, status: 200, each_serializer: TeamSerializer
    end
end