class Api::V1::TeamsController < ApplicationController
    def index
        TeamsFacade.upsert_teams
        teams = Team
            .where(name_filter)
            .where(abbr_filter)
            .where(division_filter)
            .where(conference_filter)
            .order(sort_mappings[team_params[:sort]])
            .all
        render json: teams, status: 200, each_serializer: TeamSerializer
    end

    private

        def team_params
            params.permit(:sort, :name, :abbr, :division, :conference)
        end

        def name_filter
            ['lower(name) = ?', team_params[:name].strip.downcase] unless team_params[:name].blank?
        end

        def abbr_filter
            ['lower(abbr) = ?', team_params[:abbr].strip.downcase] unless team_params[:abbr].blank?
        end

        def division_filter
            ['division ILIKE ?', "%#{team_params[:division].strip.downcase}%"] unless team_params[:division].blank?
        end

        def conference_filter
            ['conference ILIKE ?', "%#{team_params[:conference].strip.downcase}%"] unless team_params[:conference].blank?
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