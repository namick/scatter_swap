require "scatter_swap/version"
require "scatter_swap/hasher"

module ScatterSwap
  def self.hash(plain_integer, spin = 0, length = 10)
    Hasher.new(plain_integer, spin, length).hash
  end

  def self.reverse_hash(hashed_integer, spin = 0, length = 10)
    Hasher.new(hashed_integer, spin, length).reverse_hash
  end
end
