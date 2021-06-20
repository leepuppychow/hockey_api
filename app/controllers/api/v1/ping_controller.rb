class Api::V1::PingController < ApplicationController
    def index
        render json: "Hockey API is OK!", status: 200
    end
end