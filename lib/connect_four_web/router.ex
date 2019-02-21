defmodule ConnectFourWeb.Router do
  use ConnectFourWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ConnectFourWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "game/:game", PageController, :game
    post "/game", PageController, :game_form
  end

  # Other scopes may use custom stacks.
  # scope "/api", ConnectFourWeb do
  #   pipe_through :api
  # end
end
