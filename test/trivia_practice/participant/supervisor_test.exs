defmodule TrivaPractice.Participant.SupervisorTest do
  use ExUnit.Case

  alias TrivaPractice.Participant.Supervisor, as: ParticipantSupervisor

  test "starts and tracks new participant processes" do
    ParticipantSupervisor.start_link
    {:ok, player1} = ParticipantSupervisor.start_child("player1", self()) 
    {:ok, player2} = ParticipantSupervisor.start_child("player2", self()) 
    assert ParticipantSupervisor.all == [player1, player2]
  end
end
