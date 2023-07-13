defmodule EnigmaWeb.PasswordController do
  use EnigmaWeb, :controller

  def generator(conn, _params) do
    conn =
      assign(conn, :map, %{
        big_letters: true,
        numbers: true,
        special_chars: false,
        length: 25
      })

    csrf_token = Plug.CSRFProtection.get_csrf_token()
    password = Enigma.Password.generate(conn.assigns.map)
    render(conn, :password, password: password, csrf_token: csrf_token, layout: false)
  end
end
