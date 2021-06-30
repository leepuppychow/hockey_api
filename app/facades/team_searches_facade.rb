class TeamSearchesFacade
    def self.update_searches(params, teams)
        if params.empty?
            return 
        end
        team_search = TeamSearch.find_or_initialize_by(
            name: params[:name],
            abbr: params[:abbr],
            division: params[:division],
            conference: params[:conference],
        )
        team_search.frequency += 1
        team_search.teams = teams
        team_search.save
        team_search
    end
end