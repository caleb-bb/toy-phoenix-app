defmodule RumblWeb.MovieLive.Index do
  use RumblWeb, :live_view

  alias Rumbl.Movies
  alias Rumbl.Movies.Movie

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, movies: list_movies(), changeset: Movie.changeset(%Movie{}, %{title: "x", release_date: ~D[2017-01-01], blurb: "x", rating: 0}))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Movie")
    |> assign(:movie, Movies.get_movie!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Movie")
    |> assign(:movie, %Movie{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Movies")
    |> assign(:movie, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    movie = Movies.get_movie!(id)
    {:ok, _} = Movies.delete_movie(movie)

    {:noreply, assign(socket, :movies, list_movies())}
  end

    @impl true
  def handle_event("filter", %{"movie" => %{"type" => "rating", "filter" => ""}}, socket) do
    movies = Movies.list_movies()

    {:noreply, assign(socket, :movies, movies)}
  end


  @impl true
  def handle_event("filter", %{"movie" => %{"type" => "rating", "filter" => rating}}, socket) do
    movies = Movies.list_movies
    |> Enum.filter(&(&1.rating == rating |> String.to_integer))

    {:noreply, assign(socket, :movies, movies)}
  end


  @impl true
  def handle_event("filter", %{"movie" => %{"type" => "title", "filter" => ""}}, socket) do
    movies = Movies.list_movies()

    {:noreply, assign(socket, :movies, movies)}
  end


  @impl true
  def handle_event("filter", %{"_target" => ["movie", "title"], "movie" => %{"title" => title}}, socket) do
    movies = Movies.list_movies
    |> Enum.filter(&(&1.title == title))

    {:noreply, assign(socket, :movies, movies)}
  end

  defp list_movies do
    Movies.list_movies()
  end
end
