defmodule TrivaPractice.Participant.Supervisor do
  use Supervisor
  alias TrivaPractice.Participant

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def all do
    for {_, pid, _, _} <- Supervisor.which_children(__MODULE__), do: pid
  end

  def start_child(display_name, output_pid) do
    Supervisor.start_child(__MODULE__, [display_name, output_pid])
  end

  def init(:ok) do
    children = [
      worker(Participant, [], restart: :temporary)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
