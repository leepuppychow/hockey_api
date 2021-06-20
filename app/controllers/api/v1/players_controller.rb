class Api::V1::PlayersController < ApplicationController
    before_action :find_team

    def index
        if @team.players.empty?
            @team.players = TeamsFacade.get_roster(@team)
        end
        players = @team.players
            .order(sort_mappings[player_params[:sort]])
            .all

        render json: players, status: 200, each_serializer: PlayerSerializer
    end

    private
        def player_params
            params.permit(:team_abbr, :sort)
        end

        def find_team
            @team ||= Team.find_by(abbr: player_params[:team_abbr])
            if not @team
                render json: {:error => "Cannot find team #{player_params[:team_abbr]}"}, status: 404
            end
        end

        def sort_mappings
            {
                "first_name_asc" => "first_name ASC",
                "first_name_desc" => "first_name DESC",
                "last_name_asc" => "last_name ASC",
                "last_name_desc" => "last_name DESC",
            }
        end
end