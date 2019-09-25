defmodule ChatLVWeb.PageController do
  use ChatLVWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
