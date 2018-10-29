defmodule LeagueMvp.Api.V1.MatchView do
  use LeagueMvp.Web, :view
  use Protobuf, """
  message Result {
      optional string division = 1;
      optional bytes season = 2;
      optional string team_name = 3;
      optional int32 wins = 4;
      optional int32 draws = 5;
      optional int32 points = 6;
  }
"""


  def render("show.json", %{match: match}) do
    render_one(match, LeagueMvp.Api.V1.MatchView, "match.json")
  end


  def render("show_all_leagues.json", %{match: match, type: "json"}= data) do
    %{leagues: render_many(match, LeagueMvp.Api.V1.MatchView, "leagues.json")}
  end

  def render("show_all_leagues.json", %{match: match, type: "proto"}= data) do
    %{leagues: render_many(match, LeagueMvp.Api.V1.MatchView, "leagues_proto.json")}
  end

  def render("match.json", %{match: %{type: "json"}=match}) do
    %{
      division: match.division,
      season: match.season,
      team_name: match.team,
      wins: match.wins,
      draws: match.draws,
      points: match.points
    }
  end

  def render("match.json", %{match: %{type: "proto"}=match}) do
    result =  LeagueMvp.Api.V1.MatchView.Result.new(division: match.division, team_name: match.team,
      wins: match.wins, draws: match.draws, points: match.points, season: match.season)
    LeagueMvp.Api.V1.MatchView.Result.encode(result)
  end

  def render("leagues.json", %{match: match})do
    %{
      division: match.division,
      season: match.season
    }
  end

  def render("leagues_proto.json", %{match: match})do
    IO.inspect match.season
    result =  LeagueMvp.Api.V1.MatchView.Result.new(division: match.division, season: :erlang.integer_to_binary(match.season))
    LeagueMvp.Api.V1.MatchView.Result.encode(result)
  end

end
