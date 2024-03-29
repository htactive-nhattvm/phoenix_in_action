defmodule AuctionWeb.ItemController do
  use AuctionWeb, :controller

  def index(conn, _) do
    items = Auction.list_items()
    render(conn, "index.html", items: items)
  end

  def show(conn, %{"id" => id}) do
    item = Auction.get_item(id)
    render(conn, "show.html", item: item)
  end

  def new(conn, _) do
    # item = changeset
    item = Auction.new_item()
    render(conn, "new.html", item: item, action: Routes.item_path(conn, :create))
  end

  def create(conn, %{"item" => item_data}) do
    case Auction.insert_item(item_data) do
      {:ok, item} -> redirect(conn, to: Routes.item_path(conn, :show, item))
      {:error, item} -> render(conn, "new.html", item: item)
    end
  end

  def edit(conn, %{"id" => id}) do
    item = Auction.edit_item(id)
    render(conn, "edit.html", item: item)
  end

  def update(conn, %{"item" => item_data, "id" => id}) do
    item = Auction.get_item(id)

    case Auction.update_item(item, item_data) do
      {:ok, updated_item} -> render(conn, "show.html", item: updated_item)
      {:error, item} -> render(conn, "edit.html", item: item)
    end
  end
end
