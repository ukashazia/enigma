defmodule Enigma.Repo.Migrations.PasswordHistory do
  use Ecto.Migration

  def change do
    create table(:password_history) do
      add :password, :string
    end
  end
end
