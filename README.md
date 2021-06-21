# README

## Project Description
This is an API to search for NHL hockey team and roster information for the most current season. Currently, there are endpoints to search, sort, and filter team and roster information. Additionally, there are a couple analytics endpoints to see what are the most frequent queries being sent to this API. Please refer to the [issues](https://github.com/leepuppychow/hockey_api/issues) tab for enhancements and future planning.

This API was made using the data provided by the [NHL Stats API](https://gitlab.com/dword4/nhlapi/-/blob/master/stats-api.md).

[Deployed API](https://radiant-sands-65708.herokuapp.com/api/v1/teams)

## Endpoints

Base URL is: https://radiant-sands-65708.herokuapp.com

1. `GET /api/v1/ping` - [health check](https://radiant-sands-65708.herokuapp.com/api/v1/ping)

2. `GET /api/v1/teams` - [gets team information without roster data](https://radiant-sands-65708.herokuapp.com/api/v1/teams)

  - Optional filter query params. Note that partial substring matches will work as well (case insensitive). Examples:
    * name="avalanche" [Example](https://radiant-sands-65708.herokuapp.com/api/v1/teams?name=avalanche)
    * abbr="COL"
    * division="west"
    * conference="western"

  - Optional sort query params:
    * sort="name_asc" or "name_desc"
    * sort="year_asc" or "year_desc" - sorts by the teams' inaugural year

3. `GET /api/v1/teams/:team_abbr/players` - [returns players on a team](https://radiant-sands-65708.herokuapp.com/api/v1/teams/COL/players)

  - Optional filter query params. Note that partial substring matches will work as well (case insensitive). Examples:
    * first_name="Nathan"
    * last_name="mack" [Example](https://radiant-sands-65708.herokuapp.com/api/v1/teams/COL/players?last_name=mack)
    * position="C" (options C, LW, RW, D, G)
    * jersey=29

  - Optional sort query params:
    * sort="first_name_asc" or "first_name_desc"
    * sort="last_name_asc" or "last_name_desc"
    * sort="jersey_asc" or "jersey_desc"

4. `GET /api/v1/team_searches` - [returns most frequent team searches and query terms](https://radiant-sands-65708.herokuapp.com/api/v1/team_searches)

5. `GET /api/v1/roster_searches` - [returns most frequent roster searches and query terms](https://radiant-sands-65708.herokuapp.com/api/v1/roster_searches)

## Dependencies
  * Ruby 2.5.1
  * Rails 6.1.3.2
  * PostgreSQL 13.3

## Local setup
  1. Clone repository
  2. Install dependencies `bundle install`
  3. Create test and development database: `rake db:create`
  4. Run migrations: `rake db:migrate`

  5. To run test suite: `rspec`
  6. To run local server: `rails s`
  7. To connect to development postgreSQL database psql client: `rails dbconsole`
