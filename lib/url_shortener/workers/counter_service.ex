defmodule URLShortener.CounterService do
  use GenServer
  alias URLShortener.Ranges
  alias URLShortener.Ranges.Range

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, name: CounterService)
  end

  def get_next_num(pid \\ CounterService) do
    GenServer.call(pid, :next_num)
  end

  def get_state(pid \\ CounterService) do
    GenServer.call(pid, :get_state)
  end

  def set_state(pid \\ CounterService, state) do
    GenServer.cast(pid, {:set_state, state})
  end

  def stop(pid \\ CounterService), do: GenServer.stop(pid)

  @impl true
  def init(_state) do
    {:ok,
     %Range{
       lower_bound: lower_bound,
       upper_bound: upper_bound
     }} = Ranges.get_next_range()

    {:ok,
     %{
       lower_bound: lower_bound,
       current: lower_bound,
       upper_bound: upper_bound
     }}
  end

  @impl true
  def handle_call(:next_num, _from, %{current: current, upper_bound: upper_bound} = state) do
    if current == upper_bound do
      send(self(), :end_range)
      {:reply, current, {:continue, :end_range}}
    else
      {:reply, current, %{state | current: current + 1}}
    end
  end

  @impl true
  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set_state, new_state}, _state) do
    {:noreply, new_state}
  end

  @impl true
  def handle_info(:end_range, state) do
    {:stop, :normal, state}
  end
end
