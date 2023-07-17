defmodule EnigmaWeb.PasswordController do
  use EnigmaWeb, :controller

  def show(conn, _parama) do
    conn
    |> render(:password, password: "Generated Password", map: %{})
  end

  @doc """
    Generator function take raw conn.params map, converts it's string keys into
    atoms, changes the values from "on" to true. Passes the modified map to Enigma.Password.generate
    and forwards the generated password to view template
  """

  def generator(conn, params) do
    # Destructuring and modifying the map provided by Conn

    pass_length =
      Map.get(conn.params, "length")
      |> String.to_integer()

    map =
      params
      # map keys in strings are converted to atoms
      |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
      # map values in string are converted to truthy
      |> Map.new(fn {key, _value} -> {key, true} end)
      # reassignment of :length key to the previously extracted pass_length variable
      |> Map.put(:length, pass_length)
      |> Map.put(:small_letters, true)
      |> Map.delete(:_csrf_token)

    # Applying input validations

    case map do
      %{length: x} when not is_integer(x) or x == nil or x < 4 or x > 50 ->
        conn
        |> put_flash(:error, "Invalid Length")
        |> redirect(to: "/generator")

      %{length: x} when is_integer(x) and (x >= 4 or x <= 50) ->
        password = Enigma.Password.generate(map)
        render(conn, :password, password: password, map: map)
    end
  end
end
