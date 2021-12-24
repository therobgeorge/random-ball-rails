class TeamController < ApplicationController
  def show
    team = HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/teams?key=#{Rails.application.credentials.api_key}").parse(:json).sample
    players_call = HTTP.get("https://api.sportsdata.io/v3/nba/stats/json/Players/#{team["Key"]}?key=#{Rails.application.credentials.api_key}").parse(:json)
    stadium = HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/Stadiums?key=#{Rails.application.credentials.api_key}").parse(:json).select{|stadium| stadium["StadiumID"].to_s == "#{team["StadiumID"]}"}
    players = []
    players_call.each do |player|
      players << {first_name: player["FirstName"], last_name: player["LastName"], full_name: player["YahooName"], position: player["Position"]}
    end
    
    squad = {}
    squad["logo"] = team["WikipediaLogoUrl"]
    squad["players"] = players
    squad["stadium"] = stadium[0]["Name"]

    render json: squad
  end
end
