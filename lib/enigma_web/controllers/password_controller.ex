defmodule EnigmaWeb.PasswordController do
  use EnigmaWeb, :controller

  def show(conn, _parama) do
    render(conn, :password, password: "Generated password will show here", layout: false)
  end

  def generator(conn, _params) do
    # Destructuring and modifying the map provided by Conn

    pass_length =
      Map.get(conn.params, "length")
      |> String.to_integer()

    map =
      conn.params
      |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
      |> Map.new(fn {key, _value} -> {key, true} end)
      |> Map.put(:length, pass_length)

    # Applying input validations

    case map do
      %{:length => x} when not is_integer(x) or x < 4 or x > 50 ->
        conn
        |> put_flash(:error, "Invalid Length")
        |> render(:password, password: nil)

      %{:length => x} when is_integer(x) and (x >= 4 or x <= 50) ->
        password = Enigma.Password.generate(map)
        render(conn, :password, password: password, layout: false)
    end
  end
end
