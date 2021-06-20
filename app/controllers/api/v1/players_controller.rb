class Api::V1::PlayersController < ApplicationController
    before_action :find_team

    def index
        if @team.players.empty?
            @team.players = TeamsFacade.get_roster(@team)
        end
        players = @team.players
            .where(first_name_filter)
            .where(last_name_filter)
            .where(position_filter)
            .where(jersey_filter)
            .order(sort_mappings[player_params[:sort]])
            .all

        render json: players, status: 200, each_serializer: PlayerSerializer
    end

    private
        def player_params
            params.permit(:team_abbr, :sort, :first_name, :last_name, :position, :jersey)
        end

        def find_team
            @team ||= Team.find_by(abbr: player_params[:team_abbr])
            if not @team
                render json: {:error => "Cannot find team #{player_params[:team_abbr]}"}, status: 404
            end
        end

        def first_name_filter
            ['first_name ILIKE ?', "%#{player_params[:first_name].strip.downcase}%"] unless player_params[:first_name].blank?
        end

        def last_name_filter
            ['last_name ILIKE ?', "%#{player_params[:last_name].strip.downcase}%"] unless player_params[:last_name].blank?
        end

        def position_filter
            ['lower(position) = ?', player_params[:position].strip.downcase] unless player_params[:position].blank?
        end

        def jersey_filter
            ['jersey_number = ?', player_params[:jersey]] unless player_params[:jersey].blank?
        end

        def sort_mappings
            {
                "first_name_asc" => "first_name ASC",
                "first_name_desc" => "first_name DESC",
                "last_name_asc" => "last_name ASC",
                "last_name_desc" => "last_name DESC",
                "jersey_asc" => "jersey_number ASC",
                "jersey_desc" => "jersey_number DESC",
            }
        end
end