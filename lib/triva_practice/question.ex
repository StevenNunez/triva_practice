defmodule TrivaPractice.Question do
  defstruct prompt: "", options: [], correct_answer: ""
  alias __MODULE__
  def new(%{prompt: prompt, options: options, correct_answer: correct_answer}) when is_list(options) do
    %Question{ prompt: prompt, options: options, correct_answer: correct_answer }
  end
end
