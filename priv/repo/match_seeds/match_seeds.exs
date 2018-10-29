alias LeagueMvp.Repo
alias LeagueMvp.Match

File.stream!("./data/Data.csv")
|> Stream.map(fn line->
  [sno, div, season, date, hometeam, awayteam, fthg, ftag, ftr, hthg, htag, htr]= line |> String.split(",")
  if sno !="" do
    Match.changeset(%LeagueMvp.Match{}, %{match_id: sno, division: div, season: season, date: date,
      home_team: hometeam, away_team: awayteam, full_time_home_goals: fthg, full_time_away_goals: ftag,
      full_time_result: ftr, half_time_home_goals: hthg, half_time_away_goals: htag, half_time_result: htr
    })
    |> Repo.insert
  end
end)
|> Stream.run()