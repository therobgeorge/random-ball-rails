class PlayerController < ApplicationController

  def show
    player = fetch_player.sample
    team = fetch_teams.select{|team| team["Key"] == "#{player["Team"]}"}
    baller = {}
    baller["name"] = player["YahooName"]
    baller["photo"] = player["PhotoUrl"]
    baller["college"] = player["College"]
    baller["team_city"] = team[0]["City"]
    baller["team_name"] = team[0]["Name"]
    baller["jersey"] = player["Jersey"]
    baller["position"] = player["Position"]

    render json: baller
  end

  def fetch_teams
    Rails.cache.fetch(:teams, expires_in: 1.day) do
      HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/teams?key=#{Rails.application.credentials.api_key}").parse(:json)
    end
  end

  def fetch_player
    Rails.cache.fetch(:players, expires_in: 1.day) do
      HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/Players?key=#{Rails.application.credentials.api_key}").parse(:json)
    end
  end

end
