defmodule AuctionWeb.SessionController do
  use AuctionWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"user" => %{"username" => user_name, "password" => password}}) do
    case(Auction.get_user_by_username_and_pass(user_name, password)) do
      %Auction.User{} = user ->
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Successfully login")
        |> redirect(to: Routes.user_path(conn, :show, user))

      _ ->
        conn
        |> put_flash(:error, "fail")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> redirect(to: Routes.item_path(conn, :index))
  end
end
