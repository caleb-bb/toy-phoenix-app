defmodule Rumbl.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rumbl.Movies` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        blurb: "some blurb",
        rating: 42,
        release_date: ~D[2022-08-04],
        title: "some title"
      })
      |> Rumbl.Movies.create_movie()

    movie
  end
end
