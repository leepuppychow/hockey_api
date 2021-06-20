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

    def self.get_roster(team)
        json = NhlStatsapiService.get_roster(team)
        players = json[:roster].map do |player_json|
            player = Player.find_or_initialize_by(id: player_json[:person][:id])
            first_name, last_name = player_json[:person][:fullName].split(" ")
            player.first_name = first_name
            player.last_name = last_name
            player.external_url = NhlStatsapiService.base_url + player_json[:person][:link],
            player.jersey_number = player_json[:jerseyNumber]
            player.position = player_json[:position][:abbreviation]
            player.team = team
            player.save
            player
        end
    end
end