defmodule Auction.Password do
  import Pbkdf2, only: [hash_pwd_salt: 1]

  def hash(pass) do
    hash_pwd_salt(pass)
  end
end
