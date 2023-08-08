defmodule EnigmaWeb.PasswordLive do
  use EnigmaWeb, :live_view
  use Phoenix.HTML

  def mount(params, _session, socket) do
    socket =
      socket
      |> assign(:password, "Generated Password")
      |> assign(:map, params)

    {:ok, socket}
  end

  def handle_event(event, unsigned_params, socket) do
    case event do
      "generate" ->
        pass_length =
          try do
            Map.get(unsigned_params, "length")
            |> String.to_integer()
          rescue
            _ -> 0
          end

        map =
          unsigned_params

          # map keys in strings are converted to atoms
          |> Map.new(fn {key, value} -> {String.to_atom(key), value} end)
          # map values in string are converted to truthy
          |> Map.new(fn {key, _value} -> {key, true} end)
          # reassignment of :length key to the previously extracted pass_length variable
          |> Map.put(:length, pass_length)
          |> Map.put(:small_letters, true)
          |> Map.delete(:_csrf_token)
          |> Map.delete(:_target)

        # Applying input validations

        case map do
          %{length: x} when not is_integer(x) or x == nil or x < 4 or x > 50 or x == "" ->
            socket =
              socket
              |> assign(:password, "Invalid Length")
              |> assign(:map, map)
              |> put_flash(:error, "Length must be an integer form 4 to 50")

            {:noreply, socket}

          %{length: x} when is_integer(x) and (x >= 4 or x <= 50) ->
            password = Enigma.Password.generate(map)
            Enigma.Password.add_password_to_history(password)

            socket =
              socket
              |> assign(:password, password)
              |> assign(:map, map)
              |> clear_flash()

            {:noreply, socket}
        end

      # "delete" event is triggered when the user clicks on the "Delete History" button
      "delete" ->
        Enigma.Password.delete_password_history()

        socket
        |> assign(:password, "Generated Password")
        |> assign(:map, %{})
    end
  end
end
