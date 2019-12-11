defmodule Auction.Password do
  import Pbkdf2

  def hash(pass) do
    hash_pwd_salt(pass)
  end

  def verify_with_hash(password, stored_hash) do
    verify_pass(password, stored_hash)
  end

  def dummy_verify, do: no_user_verify()
end
