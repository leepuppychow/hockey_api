class Api::V1::RosterSearchesController < ApplicationController
    def index
        roster_searches = RosterSearch.order("frequency DESC").all
        render json: roster_searches, status: 200
    end
end
