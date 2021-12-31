class ApplicationController < ActionController::API
  def cache_info
    fetch_teams
    fetch_players
    fetch_stadia
    render json: {message: "cached"}
  end

  def fetch_teams
    Rails.cache.fetch(:teams, expires_in: 1.day) do
      HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/teams?key=#{Rails.application.credentials.api_key}").parse(:json)
    end
  end

  def fetch_players
    Rails.cache.fetch(:players, expires_in: 1.day) do
      HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/Players?key=#{Rails.application.credentials.api_key}").parse(:json)
    end
  end

  def fetch_stadia
    Rails.cache.fetch(:stadia, expires_in: 1.day) do
      HTTP.get("https://api.sportsdata.io/v3/nba/scores/json/Stadiums?key=#{Rails.application.credentials.api_key}").parse(:json)
    end
  end
end
