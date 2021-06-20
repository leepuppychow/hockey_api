class TeamsFacade
    def self.upsert_teams
        json = NhlStatsapiService.get_teams
        teams = json[:teams].map do |team_json|
            team = Team.find_or_initialize_by(id: team_json[:id])
            team.name = team_json[:name]
            team.abbr = team_json[:abbreviation]
            team.external_url = NhlStatsapiService.base_url + team_json[:link]
            team.division = team_json[:division][:name]
            team.conference = team_json[:conference][:name]
            team.inaugural_year = team_json[:firstYearOfPlay]
            team.save
            team
        end
    end
end