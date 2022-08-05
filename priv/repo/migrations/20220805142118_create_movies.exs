defmodule Rumbl.Repo.Migrations.CreateMovies do
  use Ecto.Migration

  def change do
    create table(:movies) do
      add :title, :string
      add :release_date, :date
      add :blurb, :string
      add :rating, :integer

      timestamps()
    end
  end
end
