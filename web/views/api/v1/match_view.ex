defmodule LeagueMvp.Api.V1.MatchView do
  use LeagueMvp.Web, :view

  def render("show.json", %{match: match}) do
    %{result: render_many(match, LeagueMvp.Api.V1.MatchView, "match.json")}
  end


  def render("show_all_leagues.json", %{match: match}) do
    %{leagues: render_many(match, LeagueMvp.Api.V1.MatchView, "leagues.json")}
  end


  def render("match.json", %{match: match}) do
    %{
      division: match.division,
      season: match.season,
      team_name: match.team,
      wins: match.wins,
      draws: match.draws,
      points: match.points
    }

  end


  def render("leagues.json", %{match: match}) do
    %{
      division: match.division,
      season: match.season
    }
  end
end
