class Api::V1::TeamsController < ApplicationController
    def index
        TeamsFacade.upsert_teams
        teams = Team
            .order(sort_mappings[team_params[:sort]])
            .all
        render json: teams, status: 200, each_serializer: TeamSerializer
    end

    private

        def team_params
            params.permit(:sort)
        end

        def sort_mappings
            {
                "name_asc" => "name ASC",
                "name_desc" => "name DESC",
                "year_asc" => "inaugural_year ASC",
                "year_desc" => "inaugural_year DESC",
            }
        end
end