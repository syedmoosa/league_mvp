defmodule LeagueMvp.Api.V1.MatchController do
  use LeagueMvp.Web, :controller

  alias LeagueMvp.Match


  def show(conn, %{"division" => division, "season"=> season, "type"=> type}= _params) do
    teams_win_stats = get_division_season(division, season, "H") |> Repo.all
    teams_draw_stats = get_division_season(division, season, "D") |> Repo.all


    # To calculate total points in league (win= 3 points, draw= 1 point)
    total_stats = calculate_points(teams_win_stats, teams_draw_stats)
    {win_points, wins, draws, team_name} = :lists.max(total_stats)
    match =  %{type: type, division: division, season: season,team: team_name, wins: wins, draws: draws, points: win_points}
    render(conn, "show.json", match: match)
  end


  def show_all_leagues(conn, %{"type" => type} = _params) do
    match = get_all_leagues() |> Repo.all
    render(conn, "show_all_leagues.json", %{match: match, type: type})
  end



  defp all_matches do
    Match
  end

  defp get_division_season(division, season, result) do

    subset_query = from(m in all_matches(),
         where: (m.division == ^division and m.season == type(^season, :integer) and m.full_time_result == ^result),
         distinct: [m.home_team, m.away_team]
    )

    from s in subquery(subset_query),
      group_by: s.home_team,
      select: {s.home_team, count(s.home_team)}

  end

  defp get_all_leagues() do
    from m in all_matches(), distinct: [m.division, m.season]
  end

  defp calculate_points(win_stats, draw_stats) do
    calculate_points(win_stats, draw_stats, draw_stats, [])
  end

  defp calculate_points([], [], _temp, acc)do
    acc
  end

  defp calculate_points([_head|tail], [], temp, acc)do
    calculate_points(tail, temp, temp, acc)
  end

  defp calculate_points([{head, wins}|t], [{head, draws}|rest], temp, acc)do
    calculate_points(t, rest, temp, [{(wins*3+draws), wins, draws, head}|acc])
  end

  defp calculate_points([head|tail], [top|rest], temp, acc)do
    calculate_points([head|tail], rest, temp, acc)
  end
end
