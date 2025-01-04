defmodule HelloWeb.CustomHTML do
  @moduledoc """
  This module contains pages rendered by CustomController.

  See the `custom_html` directory for all templates available.
  """
  use HelloWeb, :html

  embed_templates "custom_html/*"
end
