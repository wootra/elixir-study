defmodule HelloWeb.CustomController do
  use HelloWeb, :controller

  def hello(conn, params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :hello, layout: false, name: params["name"])
  end
end
