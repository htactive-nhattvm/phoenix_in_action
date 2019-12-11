defmodule AuctionWeb.UserController do
  use AuctionWeb, :controller
  plug :prevent_unauthorized_access when action in [:show]

  def show(conn, %{"id" => id}) do
    user = Auction.get_user(id)
    render(conn, "show.html", user: user)
  end

  def new(conn, _) do
    user = Auction.new_user()

    render(conn, "new.html", user: user, action: Routes.user_path(conn, :create))
  end

  def create(conn, %{"user" => user_params}) do
    case Auction.insert_user(user_params) do
      {:ok, user} -> redirect(conn, to: Routes.user_path(conn, :show, user))
      {:error, user} -> render(conn, "new.html", user: user)
    end
  end

  defp prevent_unauthorized_access(conn, _) do
    current_user = Map.get(conn.assigns, :current_user)

    id_params = conn.params |> Map.get("id") |> String.to_integer()

    if current_user == nil || current_user.id != id_params do
      conn
      |> put_flash(:error, "Nice try, friend. That's not a page for you.")
      |> redirect(to: Routes.item_path(conn, :index))
      |> halt()
    else
      conn
    end
  end
end
