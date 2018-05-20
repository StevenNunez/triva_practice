defmodule TrivaPractice.ParticipantTest do
  use ExUnit.Case
  alias TrivaPractice.Participant
  alias TrivaPractice.Question

  test "welcomes participant" do
    {:ok, _participant} = Participant.start_link("Steven", self())
    assert_receive {:welcome, "Welcome to Triva Steven!"}
  end

  test "can be asked question" do
    {:ok, participant} = Participant.start_link("Steven", self())
    question = Question.new(%{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            })
    Participant.send_question(participant, question)
    assert_receive {:next_question, question}
  end
  test "can submit response" do
    {:ok, participant} = Participant.start_link("Steven", self())
    question = Question.new(%{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            })
    Participant.send_question(participant, question)
    Participant.submit_response(participant, "???")
    assert_receive :correct
  end
  test "server stopped when incorrect response given" do
    {:ok, participant} = Participant.start_link("Steven", self())
    question = Question.new(%{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            })
    Participant.send_question(participant, question)
    Participant.submit_response(participant, "woof")
    assert_receive :incorrect
    refute Process.alive?(participant)
  end

  test "kills process if they take too long" do
    {:ok, participant} = Participant.start_link("Steven", self())
    question = Question.new(%{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            })
    Participant.send_question(participant, question)
    Participant.notify_of_round_end(participant)
    assert_receive :timeout
    refute Process.alive?(participant)
  end
end
