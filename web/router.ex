defmodule LeagueMvp.Router do
  use LeagueMvp.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", LeagueMvp.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      get "/result/division/:division/season/:season/:type", MatchController, :show
      get "/all_leagues/:type", MatchController, :show_all_leagues
    end

  end

end
