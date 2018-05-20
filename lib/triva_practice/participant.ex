defmodule TrivaPractice.Participant do
  use GenServer

  def start_link(display_name, output_pid) do
    GenServer.start_link(__MODULE__, {display_name, output_pid})
  end

  def send_question(participant, question) do
    GenServer.cast(participant, {:next_question, question})
  end

  def submit_response(participant, response) do
    GenServer.cast(participant, {:submit_response, response})
  end

  def notify_of_round_end(participant) do
    GenServer.cast(participant, :notify_of_round_end)
  end

  def init({display_name, output_pid}) do
    send output_pid, {:welcome, "Welcome to Triva #{display_name}!"}
    {:ok, %{
      display_name: display_name,
      output_pid: output_pid,
      current_round: %{
        question: %{},
        response_provided: false
      }
    }
  }
  end

  def handle_cast({:next_question, question}, %{output_pid: op} = state) do
    send op, {:next_question, question}
    state = state
    |> put_in([:current_round, :question], question)
    |> put_in([:current_round, :response_provided], false)
    {:noreply, state}
  end

  def handle_cast({:submit_response, response}, %{output_pid: op, current_round: %{question: %{correct_answer: ca}}} = state) when response == ca do
    send op, :correct
    {:noreply, put_in(state, [:current_round, :response_provided], true)}
  end

  def handle_cast({:submit_response, response}, %{output_pid: op} = state) do
    send op, :incorrect
    {:stop, :normal, state}
  end

  def handle_cast(:notify_of_round_end, %{output_pid: op, current_round: %{response_provided: false}} = state) do
    send op, :timeout
    {:stop, :normal, state}
  end

  def handle_cast(:notify_of_round_end, %{output_pid: op, current_round: %{response_provided: true}} = state) do
    {:noreply, state}
  end
end
