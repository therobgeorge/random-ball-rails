class PlayerController < ApplicationController
  require "http"

  def show
    player = HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/Players?key=#{Rails.application.credentials.api_key}").parse(:json).sample
    team = HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/teams?key=#{Rails.application.credentials.api_key}").parse(:json).select{|team| team["Key"] == "#{player["Team"]}"}
    baller = {}
    baller["college"] = player["College"]
    baller["team_city"] = team[0]["City"]
    baller["team_name"] = team[0]["Name"]
    baller["jersey"] = player["Jersey"]
    baller["position"] = player["Position"]

    render json: baller
  end
end
