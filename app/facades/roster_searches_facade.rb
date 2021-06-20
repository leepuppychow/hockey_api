class RosterSearchesFacade
    def self.update_searches(params)
        if params.empty?
            return 
        end
        roster_search = RosterSearch.find_or_initialize_by(
            team_abbr: params[:team_abbr],
            first_name: params[:first_name],
            last_name: params[:last_name],
            position: params[:position],
        )
        roster_search.frequency += 1
        roster_search.save
        roster_search
    end
end