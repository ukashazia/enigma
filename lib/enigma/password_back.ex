defmodule Enigma.PasswordBack do
  @moduledoc """
  Password module
  """

  @doc """
  Generate a random password
  map = %{
    big_letters: true,
    numbers: true,
    special_chars: true,
    length: 8
  }
  """
  def generate(map) do
    small_letters =
      Enum.to_list(?a..?z)
      |> List.duplicate(5)
      |> List.flatten()
      |> Enum.shuffle()

    big_letters =
      Enum.to_list(?A..?Z)
      |> List.duplicate(5)
      |> List.flatten()
      |> Enum.shuffle()

    numbers =
      Enum.to_list(?0..?9)
      |> List.duplicate(13)
      |> List.flatten()
      |> Enum.shuffle()

    special_chars =
      (Enum.to_list(33..47) ++
         Enum.to_list(58..64) ++
         Enum.to_list(91..96) ++
         Enum.to_list(123..126))
      |> List.duplicate(5)
      |> List.flatten()
      |> Enum.shuffle()

    case map do
      %{big_letters: true, numbers: true, special_chars: true} ->
        Enum.shuffle(small_letters ++ big_letters ++ numbers ++ special_chars)
        |> Enum.take_random(map.length)

      %{big_letters: true, numbers: true} ->
        Enum.shuffle(small_letters ++ big_letters ++ numbers)
        |> Enum.take_random(map.length)

      %{big_letters: true, special_chars: true} ->
        Enum.shuffle(small_letters ++ big_letters ++ special_chars)
        |> Enum.take_random(map.length)

      %{numbers: true, special_chars: true} ->
        Enum.shuffle(small_letters ++ numbers ++ special_chars)
        |> Enum.take_random(map.length)

      %{big_letters: true} ->
        Enum.shuffle(small_letters ++ big_letters)
        |> Enum.take_random(map.length)

      %{numbers: true} ->
        Enum.shuffle(small_letters ++ numbers)
        |> Enum.take_random(map.length)

      %{special_chars: true} ->
        Enum.shuffle(small_letters ++ special_chars)
        |> Enum.take_random(map.length)

      %{} ->
        Enum.shuffle(small_letters)
        |> Enum.take_random(map.length)
    end
  end
end
