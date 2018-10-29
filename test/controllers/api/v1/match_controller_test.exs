defmodule LeagueMvp.Api.V1.MatchControllerTest do
  use LeagueMvp.ConnCase

  alias LeagueMvp.Match
  @valid_attrs %{away_team: "some away_team", date: "some date", division: "some division", full_time_away_goals: 42, full_time_home_goals: 42, full_time_result: "some full_time_result", half_time_away_goals: 42, half_time_home_goals: 42, half_time_result: "some half_time_result", home_team: "some home_team", match_id: 42, season: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, api_v1_match_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = get conn, api_v1_match_path(conn, :show, match)
    assert json_response(conn, 200)["data"] == %{"id" => match.id,
      "match_id" => match.match_id,
      "division" => match.division,
      "season" => match.season,
      "date" => match.date,
      "home_team" => match.home_team,
      "away_team" => match.away_team,
      "full_time_home_goals" => match.full_time_home_goals,
      "full_time_away_goals" => match.full_time_away_goals,
      "full_time_result" => match.full_time_result,
      "half_time_home_goals" => match.half_time_home_goals,
      "half_time_away_goals" => match.half_time_away_goals,
      "half_time_result" => match.half_time_result}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, api_v1_match_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, api_v1_match_path(conn, :create), match: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Match, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, api_v1_match_path(conn, :create), match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = put conn, api_v1_match_path(conn, :update, match), match: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Match, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = put conn, api_v1_match_path(conn, :update, match), match: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    match = Repo.insert! %Match{}
    conn = delete conn, api_v1_match_path(conn, :delete, match)
    assert response(conn, 204)
    refute Repo.get(Match, match.id)
  end
end
