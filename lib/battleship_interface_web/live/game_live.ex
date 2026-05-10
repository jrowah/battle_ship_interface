defmodule BattleshipInterfaceWeb.GameLive do
  use BattleshipInterfaceWeb, :live_view

  alias BattleShip.GameSupervisor

  @spec mount(map(), any(), any()) :: {:ok, any()}
  def mount(%{"name" => name}, _session, socket) do
    pid =
      case GameSupervisor.start_game(name) do
        {:ok, pid} -> pid
        {:error, {:already_started, pid}} -> pid
      end

    socket
    |> assign(name: name, game_pid: pid)
    |> put_flash(:info, "You have joined the game as #{name}")

    {:ok, socket}
  end

  @spec render(any()) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <div class="flex h-screen items-center justify-center">
      <h1 class="text-4xl font-bold">Game Live View</h1>
    </div>
    """
  end
end
