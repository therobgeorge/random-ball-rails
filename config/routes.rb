Rails.application.routes.draw do
  get "/cache_info" => "application#cache_info"
  get "/player" => "player#show"
  get "/team" => "team#show"
end
