defmodule EnigmaWeb.HomeLive do
  use EnigmaWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_event("redirect", _params, socket) do
    {:noreply, push_redirect(socket, to: "/generator")}
  end
end
