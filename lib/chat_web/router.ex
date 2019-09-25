defmodule ChatLVWeb.Router do
  use ChatLVWeb, :router

  import Phoenix.LiveView.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug Phoenix.LiveView.Flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatLVWeb do
    pipe_through :browser

    live "/", ChatLiveView
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatLVWeb do
  #   pipe_through :api
  # end
end
