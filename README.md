# README

## Project Description
This is an API to search for NHL hockey team and roster information for the 2020-2021 season. 

## Endpoints

1. GET /api/v1/teams (would get all teams with no roster info, maybe paginate?)
  - Filter query params:
    * name="Colorado Avalanche"
    * abbr="COL"
    * division="west"
    * conference="western"
  - Sort query params:
    * sort="name_asc" or "name_desc" (default is ASC)
    * sort="year_asc" or "year_desc"

2. GET /api/v1/teams/COL/players (use a slug based on the team abbr value, would return all players on team)
      ~~> Slugs: https://backend.turing.edu/module2/lessons/callbacks_and_refactoring

  - Filter Query Params:
    * full_name="Nathan MacKinnon"
    * position="C" (options C, LW, RW, D, G)
    * jersey=29
  - Sort query params
    * sort="name_asc" or "name_desc" (default is ASC)
    * sort="jersey_asc" or "jersey_desc"

3. GET /api/v1/searches (more like an analytics endpoint to see what people are searching for)
  - Returns JSON with 2 arrays of team and roster searches

MODELS

1. Team (note use updated_at timestamp and if current date is > 1 day call external API and refresh this cache)
  - id
  - name
  - abbr
  - external_url
  - division
  - conference
  - inaugural_year

2. Player (note use updated_at timestamp and if current date is > 1 day call external API and refresh this cache)
  - id
  - id_team
  - full_name
  - external_url
  - jersey_number
  - position (C, LW, RW, D, G)

3. TeamSearch (unique on name + abbr + division + conference)
  - id
  - frequency
  - name
  - abbr
  - division
  - conference

4. RosterSearch (unique on team_abbr, full_name, position, jersey_number)
  - id
  - frequency
  - team_abbr
  - full_name
  - position
  - jersey_number

~~> Mocking API calls in tests: https://backend.turing.edu/module3/lessons/testing_tools_for_api_consumption
~~> Facades and Services: https://backend.turing.edu/module3/lessons/refactoring_api_consumption
~~> Error handling in Rails: https://backend.turing.edu/module3/lessons/error_handling
~~> Redis caching with Rails: http://jameshuynh.com/cache/json/rails/2017/08/13/how-to-effectively-cache-json-in-api-rails-app/
  - Could use another layer of caching with Redis (but for now get MVP working)


* Versions:
  * Ruby 2.5.0
  * Rails 6.1.3.2

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
