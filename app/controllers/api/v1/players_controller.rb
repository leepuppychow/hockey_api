class Api::V1::PlayersController < ApplicationController
    before_action :find_team

    def index
        if @team.players.empty?
            @team.players = TeamsFacade.get_roster(@team)
        end
        render json: @team.players, status: 200, each_serializer: PlayerSerializer
    end

    private
        def player_params
            params.permit(:team_abbr)
        end

        def find_team
            @team ||= Team.find_by(abbr: player_params[:team_abbr])
            if not @team
                render json: {:error => "Cannot find team #{player_params[:team_abbr]}"}, status: 404
            end
        end
end