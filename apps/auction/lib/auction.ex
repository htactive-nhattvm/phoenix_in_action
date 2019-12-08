defmodule Auction do
  alias Auction.Item

  @repo Auction.Repo

  def get_list() do
    @repo.all(Item)
  end

  def get_by_id(id) do
    @repo.get!(Item, id)
  end

  def get_item(id) do
    get_by_id(id)
    |> Item.changeset()
  end

  def update_item(%Auction.Item{} = item, updates) do
    item
    |> Item.changeset(updates)
    |> @repo.update
  end
end
