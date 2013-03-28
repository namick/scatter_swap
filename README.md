# ScatterSwap

This is the hashing function behind ObfuscateId.
https://github.com/namick/obfuscate_id

Designing a hash function is a bit of a black art and
being that I don't have math background, I must resort
to this simplistic swaping and scattering of array elements.

After writing this and reading/learning some elemental hashing techniques,
I realize this library is what is known as a Minimal perfect hash function:
http://en.wikipedia.org/wiki/Perfect_hash_function#Minimal_perfect_hash_function

I welcome all improvements :-)

If you have some comments or suggestions, please contact me on github
https://github.com/namick

- nathan amick


This library is built for integers that can be expressed with 10 digits:
It zero pads smaller numbers... so the number 1 is expressed with:
0000000001

The biggest number it can deal with is:
9999999999

Since we are working with a limited sequential set of input integers, 10 billion,
this algorithm will suffice for simple id obfuscation for many web apps.
The largest value that Ruby on Rails default id, Mysql INT type, is just over 2 billion (2147483647)
which is the same as 2 to the power of 31 minus 1, but considerably less than 10 billion.

ScatterSwap is an integer hash function designed to have:
- zero collisions ( http://en.wikipedia.org/wiki/Perfect_hash_function )
- achieve avalanche ( http://en.wikipedia.org/wiki/Avalanche_effect )
- reversable

We do that by combining two distinct strategies.

1. Scattering - whereby we take the whole number, slice it up into 10 digits
and rearange their places, yet retaining the same 10 digits.  This allows
us to preserve the sum of all the digits, regardless of order.  This sum acts
as a key to reverse this scattering effect.

2. Swapping - when dealing with many sequential numbers that we don't want
to look similar, scattering wont do us much good because so many of the
digits are the same; it deoesn't help to scatter 9 zeros around, so we need
to swap out each of those zeros for something else.. something different
for each place in the 10 digit array; for this, we need a map so that we
can reverse it.

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'scatter_swap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scatter_swap

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
