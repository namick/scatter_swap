require "scatter_swap/version"
require "scatter_swap/hasher"

module ScatterSwap
  def self.hash(plain_integer, spin = 0)
    Hasher.new(spin).hash(plain_integer)
  end

  def self.reverse_hash(hashed_integer, spin = 0)
    Hasher.new(spin).reverse_hash(hashed_integer)
  end
end
