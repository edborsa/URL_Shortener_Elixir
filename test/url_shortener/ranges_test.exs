defmodule URLShortener.RangesTest do
  use URLShortener.DataCase
  import URLShortener.Factory
  alias URLShortener.Ranges
  alias URLShortener.Ranges.Range

  describe "ranges" do
    test "list_ranges/0 returns all ranges" do
      range = insert(:range)
      assert Ranges.list_ranges() == [range]
    end

    test "get_range!/1 returns the range with given id" do
      range = insert(:range)
      assert Ranges.get_range!(range.id) == range
    end

    test "create_range/1 with valid data creates a range" do
      valid_attrs = params_for(:range)

      assert {:ok, %Range{} = range} = Ranges.create_range(valid_attrs)
      assert range.lower_bound == valid_attrs.lower_bound
      assert range.upper_bound == valid_attrs.upper_bound
    end

    test "create_range/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ranges.create_range(%{lower_bound: -5})
    end

    test "update_range/2 with valid data updates the range" do
      range = insert(:range)

      update_attrs = params_for(:range)

      assert {:ok, %Range{} = range} = Ranges.update_range(range, update_attrs)
      assert range.lower_bound == update_attrs.lower_bound
      assert range.upper_bound == update_attrs.upper_bound
    end

    test "update_range/2 with invalid data returns error changeset" do
      range = insert(:range)
      assert {:error, %Ecto.Changeset{}} = Ranges.update_range(range, %{lower_bound: -5})
      assert range == Ranges.get_range!(range.id)
    end

    test "delete_range/1 deletes the range" do
      range = insert(:range)
      assert {:ok, %Range{}} = Ranges.delete_range(range)
      assert_raise Ecto.NoResultsError, fn -> Ranges.get_range!(range.id) end
    end

    test "change_range/1 returns a range changeset" do
      range = insert(:range)
      assert %Ecto.Changeset{} = Ranges.change_range(range)
    end
  end
end
