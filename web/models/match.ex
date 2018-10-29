defmodule LeagueMvp.Match do
  use LeagueMvp.Web, :model

  schema "matches" do
    field :match_id, :integer
    field :division, :string
    field :season, :integer
    field :date, :string
    field :home_team, :string
    field :away_team, :string
    field :full_time_home_goals, :integer
    field :full_time_away_goals, :integer
    field :full_time_result, :string
    field :half_time_home_goals, :integer
    field :half_time_away_goals, :integer
    field :half_time_result, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:match_id, :division, :season, :date, :home_team, :away_team, :full_time_home_goals, :full_time_away_goals, :full_time_result, :half_time_home_goals, :half_time_away_goals, :half_time_result])
    |> validate_required([:match_id, :division, :season, :date, :home_team, :away_team, :full_time_home_goals, :full_time_away_goals, :full_time_result, :half_time_home_goals, :half_time_away_goals, :half_time_result])
  end
end
