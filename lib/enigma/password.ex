defmodule Enigma.Password do
  def generate(map) do
    char_map = %{
      small_letters: Enum.to_list(?a..?z) |> List.duplicate(5),
      big_letters: Enum.to_list(?A..?Z) |> List.duplicate(5),
      numbers: Enum.to_list(?0..?9) |> List.duplicate(12),
      special_chars:
        (Enum.to_list(33..47) ++
           Enum.to_list(58..64) ++
           Enum.to_list(91..96) ++
           Enum.to_list(123..126))
        |> List.duplicate(5)
    }

    Enum.map(map, fn {key, _} -> {key, Map.get(char_map, key)} end)
    |> Enum.into(%{})
    |> Map.delete(:length)
    |> Map.put(:small_letters, char_map.small_letters)
    |> Map.values()
    |> List.flatten()
    |> Enum.shuffle()
    |> Enum.reject(&(&1 == nil))
    |> Enum.take(map.length)
  end
end
