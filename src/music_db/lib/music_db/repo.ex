defmodule MusicDb.Repo do
  use Ecto.Repo,
    otp_app: :music_db,
    adapter: Ecto.Adapters.Postgres

  def using_postgres? do
    MusicDb.Repo.__adapter__ == Ecto.Adapters.Postgres
  end

end
