class Api::V1::TeamSearchesController < ApplicationController
    def index
        team_searches = TeamSearch.order("frequency DESC").all
        render json: team_searches, status: 200, each_serializer: TeamSearchSerializer  
    end
end
