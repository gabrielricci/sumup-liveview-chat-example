defmodule ChatLV.Chat do
  use GenServer

  # ------------------------------------------------------------------------------
  # api
  # ------------------------------------------------------------------------------
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def get_chat() do
    GenServer.call(__MODULE__, :get_chat)
  end

  def new_message(message) do
    GenServer.call(__MODULE__, {:new_message, message})
  end

  # ------------------------------------------------------------------------------
  # callbacks
  # ------------------------------------------------------------------------------
  @impl true
  def init(_) do
    {:ok, %{name: "My SumUp Chat", messages: []}}
  end

  @impl true
  def handle_call({:new_message, data}, _from, %{messages: messages} = state) do
    new_state = %{state | messages: [data | messages]}
    {:reply, new_state, new_state}
  end

  @impl true
  def handle_call(:get_chat, _from, state) do
    {:reply, state, state}
  end
end
