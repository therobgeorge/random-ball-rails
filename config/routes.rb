Rails.application.routes.draw do
  get "/player" => "player#show"
  get "/team" => "team#show"
end
