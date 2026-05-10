defmodule BattleshipInterfaceWeb.PageController do
  use BattleshipInterfaceWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
