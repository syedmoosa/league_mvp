defmodule LeagueMvp.MatchTest do
  use LeagueMvp.ModelCase

  alias LeagueMvp.Match

  @valid_attrs %{away_team: "some away_team", date: "some date", division: "some division", full_time_away_goals: 42, full_time_home_goals: 42, full_time_result: "some full_time_result", half_time_away_goals: 42, half_time_home_goals: 42, half_time_result: "some half_time_result", home_team: "some home_team", match_id: 42, season: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Match.changeset(%Match{}, @invalid_attrs)
    refute changeset.valid?
  end
end
