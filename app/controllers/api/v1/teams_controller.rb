class Api::V1::TeamsController < ApplicationController
    def index
        teams = TeamsFacade.teams
        render json: teams, status: 200, each_serializer: TeamSerializer
    end
end