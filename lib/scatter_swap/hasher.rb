module ScatterSwap
  class Hasher
    def initialize(spin = 0)
      @spin = spin
    end

    # obfuscates an integer up to 10 digits in length
    def hash(plain_integer)
      working_array = build_working_array(plain_integer)
      working_array = swap(working_array)
      working_array = scatter(working_array)
      return completed_string(working_array)
    end

    # de-obfuscates an integer
    def reverse_hash(hashed_integer)
      working_array = build_working_array(hashed_integer)
      working_array = unscatter(working_array)
      working_array = unswap(working_array)
      return completed_string(working_array)
    end

    def completed_string(working_array)
      working_array.join
    end

    # We want a unique map for each place in the original number
    def swapper_map(index)
      # Lazy load the swapper_map for this index
      if (!_swapper_maps || !_swapper_maps[index])
        _swapper_maps ||= []
        index_swapper_map = []

        array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        10.times do |i|
          index_swapper_map << array.rotate!(index + i ^ spin).pop
        end

        _swapper_maps[index] = index_swapper_map
      end

      return _swapper_maps[index]
    end

    # Using a unique map for each of the ten places,
    # we swap out one number for another
    def swap(working_array)
      swapped_working_array = working_array.collect.with_index do |digit, index|
        swapper_map(index)[digit]
      end

      return swapped_working_array
    end

    # Reverse swap
    def unswap(working_array)
      unswapped_working_array = working_array.collect.with_index do |digit, index|
        swapper_map(index).rindex(digit)
      end

      return unswapped_working_array
    end

    # Rearrange the order of each digit in a reversable way by using the 
    # sum of the digits (which doesn't change regardless of order)
    # as a key to record how they were scattered
    def scatter(working_array)
      sum_of_digits = working_array.inject(:+).to_i
      rotation = spin ^ sum_of_digits
      scattered_working_array = 10.times.collect do
        working_array.rotate!(rotation).pop
      end

      return scattered_working_array
    end

    # Reverse the scatter
    def unscatter(working_array)
      scattered_array = working_array
      sum_of_digits = scattered_array.inject(:+).to_i
      rotation = (sum_of_digits ^ spin) * -1
      unscattered_working_array = []
      unscattered_working_array.tap do |unscatter|
        10.times do
          unscatter << scattered_array.pop
          unscatter.rotate!(rotation)
        end
      end

      return unscattered_working_array
    end

    # Add some spice so that different apps can have differently mapped hashes
    def spin
      @spin || 0
    end

    def build_working_array(original_integer)
      zero_pad = original_integer.to_s.rjust(10, '0')
      return zero_pad.split("").collect {|d| d.to_i}
    end

    private
      attr_accessor :_swapper_maps
  end
end
