defmodule AuctionWeb.Authenticator do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # IO.inspect(Map.get(conn, :cookies))
    # IO.inspect(Map.get(conn, :req_cookies))
    IO.inspect(Map.get(conn, :secret_key_base))

    user =
      conn
      |> get_session(:user_id)
      |> case do
        nil -> nil
        id -> Auction.get_user(id)
      end

    assign(conn, :current_user, user)
  end
end
