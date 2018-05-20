# TrivaPractice

## Random notes
Trivia!

defmodule Triva.Question do
  def questions do
  # maybe read these on start?
  # Backed by Mnesia DB
  end
end

defmodule Trivia.ParticipantRegistry do
  def all
end

defmodule Trivia.ParticipantSupervisor do
  simple_one_for_one temporary
end

defmodule Trivia.Round do
  def begin do
    # Get all participants
    # Get Next Question and Answer (Question Stream?)
    # send participant, {:next_question, %{question: question, answer: answer}}
    # send self a message to go on to next question handle when all questions are done.
  end
end

defmodule Trivia.Participant do
  def start_link(name, output_pid) do
    # add to participant registry
  end
  
  def answer(participant, answer) do
    cast
  end
  
  def handle_cast({:answer, answer}, %{expected_answer: answer, output_pid: output_pid} = state) when answer == expected_answer do
    send output_pid, :correct
  end
  def handle_cast({:answer, answer}, %{output_pid: output_pid} = state) do
    send output_pid, :incorrect
    {:stop, state}
  end

  def handle_info({:next_question, %{question: q, answer: a}}, %{output_pid: output_pid} = state) do
    send output_pid, {:next_question, q}
    {:noreply, Map.put(state, :expected_answer, a)
  end
end


Start with a simple one for one genserver that represents every round a user is playing.
Track all of the 

Ingredients
-Upgrades
-Distrubution
-Fault Tolerance
-Distributed data store
-Built in OTP goodies (Mnesia, observer)

Goal:
  1 real human connections
  phx -> 5 elixir instances
  phx -
   connections, LB, state (playing, lost)
  trivia -
    q, a, game rules, track answers, enforce time limits
  
  
Make new project

Create the participant
Define GenServer, start_link(display_name, output_pid) (Later add uuid with an upgrade)
Define get_name
Welcome in init to output_pid
Show Observer

Setup Question
  Question Struct
  query: "", options: [], correct_answer: ""



Where do questions come from? Stork
File/yaml
GenServer
  add question
  k

Registry
Round with question as argument

QuestionServer.next_question
Round/Rule/Game
Round.start(question)
Round.start
  q = QS.next_question
  p = PRegistry.all
  for part <- p
   Participant.send_question(p, q)
  end
  Process.send_after 10_000, :end_round

  :end_round
    clean up
    start new round
