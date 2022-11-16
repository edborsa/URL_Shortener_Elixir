defmodule URLShortener.Helpers.Encoder do
  def encode_base_62(num) when is_integer(num) do
    encode_base_62(num, "")
  end

  defp encode_base_62(num, acc) when num < 62 do
    new_char = Enum.at(base_62_graphemes(), rem(num, 62))
    new_char <> acc
  end

  defp encode_base_62(num, acc) when num >= 62 do
    new_char = Enum.at(base_62_graphemes(), rem(num, 62))
    encode_base_62(div(num, 62), new_char <> acc)
  end

  defp base_62_graphemes() do
    "0123456789abcdefghijklmnopqrstuvxwyzABCDEFGHIJKLMNOPQRSTUVXWYZ"
    |> String.graphemes()
  end
end
