defmodule EnigmaWeb.PasswordController do
  use EnigmaWeb, :controller

  def generator(conn, _params) do
    password = ["one", "two", "three", "four"]
    render(conn, :password, password: password, layout: false)
  end
end
