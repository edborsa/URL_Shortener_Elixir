defmodule UrlShortener.Helpers.EncoderTest do
  use URLShortener.DataCase

  alias URLShortener.Helpers.Encoder

  describe "encode_base_62/1" do
    test "SUCCESS: Encode some values" do
      assert Encoder.encode_base_62(0) == "0"
      assert Encoder.encode_base_62(9) == "9"
      assert Encoder.encode_base_62(10) == "a"
      assert Encoder.encode_base_62(35) == "z"
      assert Encoder.encode_base_62(36) == "A"
      assert Encoder.encode_base_62(61) == "Z"
      assert Encoder.encode_base_62(62) == "10"
      assert Encoder.encode_base_62(999) == "g7"
    end

    test "ERROR: Encode some values" do
      assert Encoder.encode_base_62(-1) == {:error, "can't encode input"}
    end
  end
end
