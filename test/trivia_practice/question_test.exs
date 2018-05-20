defmodule TrivaPractice.QuestionTest do
  use ExUnit.Case
  alias TrivaPractice.Question

  test "has contstructor for question" do
    question = Question.new(%{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            })
    assert question == %Question{
                              prompt: "What does the fox say?", 
                              options: ["woof", "meow", "???"], 
                              correct_answer: "???"
                            }

  end

  test "requires options to be a list" do
    assert_raise FunctionClauseError, fn ->
      Question.new(%{
                      prompt: "What does the fox say?", 
                      options: :not_a_list, 
                      correct_answer: "???"
                    })
    end
  end
end
