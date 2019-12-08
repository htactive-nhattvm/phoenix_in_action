defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller

  def index(conn, _) do
    items = Auction.get_list()
    render(conn, "index.html", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_by_id(id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.get_item(id)
    render(conn, "edit.html", item: item)
  end

  def update(conn, %{"item" => item_data, "id" => id}) do
    item = Auction.get_by_id(id)
    case Auction.update_item(item, item_data) do
      {:ok, updated_item} -> render(conn, "show.html", item: updated_item)
      {:error, item} -> render(conn, "edit.html", item: item)
    end

    items = Auction.get_list()
    render(conn, "index.html", items: items)
  end
end
