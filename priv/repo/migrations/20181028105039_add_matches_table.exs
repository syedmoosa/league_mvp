defmodule LeagueMvp.Repo.Migrations.AddMatchesTable do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :match_id, :integer
      add :division, :string
      add :season, :integer
      add :date, :string
      add :home_team, :string
      add :away_team, :string
      add :full_time_home_goals, :integer
      add :full_time_away_goals, :integer
      add :full_time_result, :string
      add :half_time_home_goals, :integer
      add :half_time_away_goals, :integer
      add :half_time_result, :string

      timestamps()
    end
  end
end
