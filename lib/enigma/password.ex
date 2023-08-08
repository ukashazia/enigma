defmodule Enigma.Password do
  def generate(map) do
    pass_length = map.length
    map_size = map |> Map.keys() |> length() |> Kernel.-(1)
    factor = div(pass_length, map_size)

    char_map = %{
      small_letters: Enum.to_list(?a..?z) |> Enum.take_random(factor),
      big_letters: Enum.to_list(?A..?Z) |> Enum.take_random(factor),
      numbers: Enum.to_list(?0..?9) |> Enum.take_random(factor),
      special_chars:
        (Enum.to_list(33..47) ++
           Enum.to_list(58..64) ++
           Enum.to_list(91..96) ++
           Enum.to_list(123..126))
        |> Enum.take_random(factor)
    }

    Enum.map(map, fn {key, _} -> {key, Map.get(char_map, key)} end)
    |> Enum.into(%{})
    |> Map.delete(:length)
    |> Map.values()
    |> List.flatten()
    |> Enum.shuffle()
    |> Enum.concat(Enum.to_list(?a..?z) |> Enum.shuffle())
    |> Enum.take(map.length)
    |> Enum.shuffle()
    |> to_string()
  end
end
