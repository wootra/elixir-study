defmodule Candidate do
  defstruct [:name, :vote, :id]

  def new(name, id) do
    %Candidate{name: name, vote: 0, id: id}
  end
end
