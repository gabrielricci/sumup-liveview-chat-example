# Create app

- setup dependencies and requirements
- `mix new study_chatlv --module ChatLV --no-ecto`
- create `ChatLV.Chat`
- create `templates/chat/show.html.leex`
- create `ChatLVWeb.ChatLiveView`
- create `live/chat_live_view.ex`
- create `views/chat_view.ex`
- setup router
- setup supervisor

# Dependencies and requirements

## deps

```
{:phoenix_live_view, "~> 0.3.0"},
```

## config.exs

```
config :study_chatlv, ChatLVWeb.Endpoint,
  ...
  live_view: [signing_salt: "YOUR_SECRET"]
```

```
config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]
```

## router.ex

```
import Phoenix.LiveView.Router

pipeline :browser do
  ...
  plug Phoenix.LiveView.Flash
```

## endpoint.ex

```
socket "/live", Phoenix.LiveView.Socket
```

## package.json

```
"phoenix_live_view": "file:../deps/phoenix_live_view"
```
and then
```
npm install --prefix assets
```

## app.js

```
// setup live view
import {Socket} from "phoenix"
import LiveSocket from "phoenix_live_view"

let liveSocket = new LiveSocket("/live", Socket)
liveSocket.connect()
```

# PubSub

- Change `chat_live_view.ex`

```
...
mount(...) do
  ChatLVWeb.Endpoint.subscribe("chat:sumup")
  ...
end

...

handle_event(...) do
  ...
  ChatLVWeb.Endpoint.broadcast_from(self(), "chat:sumup", "message_received", %{chat: chat})
  ...
end

...

def handle_info(%{event: "message_received", payload: state}, socket) do
  {:noreply, assign(socket, state)}
end
```


# Deploying to heroku

- `heroku create --buildpack hashnuke/elixir`
- `heroku buildpacks:add https://github.com/gjaldon/heroku-buildpack-phoenix-static.git`
- `echo "web: mix phx.server" > Procfile`
- `heroku config:set SECRET_KEY_BASE="xvafzY4y01jYuzLm3ecJqo008dVnU3CN4f+MamNd1Zue4pXvfvUjbiXT8akaIF53"`
- Copy the `elixir_buildpack.config` file

# How it works

- https://elixirschool.com/assets/live_view-6a1ff8ddee59b55d1ee0b72dc8d47c55e55bdcaf6b788cc65af31afec66836d3.png
