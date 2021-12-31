class PlayerController < ApplicationController

  def show
    player = fetch_players.sample
    team = fetch_teams.select{|team| team["Key"] == "#{player["Team"]}"}
    baller = {name: player["YahooName"], photo: player["PhotoUrl"], college: player["College"], team_city: team[0]["City"], team_name: team[0]["Name"], jersey: player["Jersey"], position: player["Position"]}
    render json: baller
  end



end
