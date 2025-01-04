defmodule HelloWeb.VoteHTML do
  use HelloWeb, :html

  embed_templates "vote_html/*"

  @doc """
  Renders a vote form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def vote_form(assigns)
end
