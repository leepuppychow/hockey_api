class TeamsFacade
    def self.teams
        json = NhlStatsapiService.get_teams
        teams = json[:teams].map do |team_json|
            team = Team.create(
                id: team_json[:id],
                name: team_json[:name],
                abbr: team_json[:abbreviation],
                external_url: NhlStatsapiService.base_url + team_json[:link],
                division: team_json[:division][:name],
                conference: team_json[:conference][:name],
                inaugural_year: team_json[:firstYearOfPlay],
            )
        end
    end
end