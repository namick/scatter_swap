require "scatter_swap/version"
require "scatter_swap/hasher"

module ScatterSwap
  def self.hash(plain_integer, spin = 0)
    Hasher.new(plain_integer, spin).hash
  end

  def self.reverse_hash(hashed_integer, spin = 0)
    Hasher.new(hashed_integer, spin).reverse_hash
  end
end
