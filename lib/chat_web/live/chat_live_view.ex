defmodule ChatLVWeb.ChatLiveView do
  use Phoenix.LiveView

  alias ChatLV.Chat

  def render(assigns) do
    ChatLVWeb.ChatView.render("show.html", assigns)
  end

  def mount(%{}, socket) do
    ChatLVWeb.Endpoint.subscribe("chat:sumup")

    chat = ChatLV.Chat.get_chat()
    {:ok, assign(socket, chat: chat)}
  end

  def handle_event("new_message", %{"content" => message_data}, socket) do
    chat = Chat.new_message(message_data)

    ChatLVWeb.Endpoint.broadcast_from(self(), "chat:sumup", "message_received", %{chat: chat})

    {:noreply, assign(socket, chat: chat)}
  end

  def handle_info(%{event: "message_received", payload: state}, socket) do
    {:noreply, assign(socket, state)}
  end
end
