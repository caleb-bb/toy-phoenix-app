defmodule Rumbl.MoviesTest do
  use Rumbl.DataCase

  alias Rumbl.Movies

  describe "movies" do
    alias Rumbl.Movies.Movie

    import Rumbl.MoviesFixtures

    @invalid_attrs %{blurb: nil, rating: nil, release_date: nil, title: nil}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Movies.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Movies.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{blurb: "some blurb", rating: 42, release_date: ~D[2022-08-04], title: "some title"}

      assert {:ok, %Movie{} = movie} = Movies.create_movie(valid_attrs)
      assert movie.blurb == "some blurb"
      assert movie.rating == 42
      assert movie.release_date == ~D[2022-08-04]
      assert movie.title == "some title"
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{blurb: "some updated blurb", rating: 43, release_date: ~D[2022-08-05], title: "some updated title"}

      assert {:ok, %Movie{} = movie} = Movies.update_movie(movie, update_attrs)
      assert movie.blurb == "some updated blurb"
      assert movie.rating == 43
      assert movie.release_date == ~D[2022-08-05]
      assert movie.title == "some updated title"
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_movie(movie, @invalid_attrs)
      assert movie == Movies.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Movies.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Movies.change_movie(movie)
    end
  end
end
