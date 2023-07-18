defmodule Enigma.PasswordHistory do
  use Ecto.Schema

  schema "password_history" do
    field :password, :string
  end
end
