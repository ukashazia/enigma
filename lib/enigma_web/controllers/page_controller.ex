defmodule EnigmaWeb.PageController do
  use EnigmaWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end
end
