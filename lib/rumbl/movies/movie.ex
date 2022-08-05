defmodule Rumbl.Movies.Movie do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movies" do
    field :blurb, :string
    field :rating, :integer
    field :release_date, :date
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :release_date, :blurb, :rating])
    |> validate_required([:title, :release_date, :blurb, :rating])
  end
end
