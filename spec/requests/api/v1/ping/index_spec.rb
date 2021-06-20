require 'rails_helper'

describe "Health check ping endpoint" do
    it "/api/v1/ping will return a successful health check response" do
        get "/api/v1/ping"

        expect(response.status).to eq 200
        expect(response.body).to eq "Hockey API is OK!"
    end
end