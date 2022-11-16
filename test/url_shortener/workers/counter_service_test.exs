defmodule URLShortener.Workers.CounterServiceTest do
  use ExUnit.Case
  use URLShortener.DataCase, async: false
  alias URLShortener.CounterService
  alias Ecto.Adapters.SQL.Sandbox

  describe "bulk_create_suppliers/0" do
    setup _context do
      pid = start_supervised!(CounterService)
      Sandbox.allow(URLShortener.Repo, self(), pid)
      %{counter_pid: pid}
    end

    test "SUCCESS: Process is start when application bots" do
      assert {:error, {:already_started, pid}} = CounterService.start_link([])
      assert Process.alive?(pid)
      CounterService.stop()
    end

    test "SUCCESS: Counter Service Current Value is increased after getting next num", %{
      counter_pid: pid
    } do
      previous_state = CounterService.get_state(pid)
      CounterService.get_next_num()
      next_state = CounterService.get_state()
      assert previous_state.current + 1 == next_state.current
    end

    test "SUCCESS: Can set state of the Genserver" do
      CounterService.set_state(%{
        lower_bound: 1,
        current: 2,
        upper_bound: 3
      })

      new_state = CounterService.get_state()
      assert new_state == %{current: 2, lower_bound: 1, upper_bound: 3}
    end

    test "SUCCESS: After ending the range, spawns a new genserver", %{counter_pid: counter_pid} do
      CounterService.set_state(%{
        lower_bound: 1,
        current: 3,
        upper_bound: 3
      })

      CounterService.get_next_num()

      {_, {_, new_pid}} = CounterService.start_link([])
      assert counter_pid != new_pid
    end
  end
end
