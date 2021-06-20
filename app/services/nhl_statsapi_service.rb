class NhlStatsapiService
    def self.base_url
        "https://statsapi.web.nhl.com"
    end

    def self.conn
        Faraday.new(url: self.base_url)
    end

    def self.get_teams
        response = conn.get("/api/v1/teams")
        JSON.parse(response.body, symbolize_names: true)
    end
end