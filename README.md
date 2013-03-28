# ScatterSwap

This is the integer hashing function behind [obfuscate_id](https://github.com/namick/obfuscate_id).

> Designing a hash function is a bit of a black art and
> being that I don't have math background, I must resort
> to this simplistic swaping and scattering of array elements.

> After writing this and reading/learning some elemental hashing techniques,
> I realized that this library is an example of what is known as a [minimal perfect hash function](http://en.wikipedia.org/wiki/Perfect_hash_function#Minimal_perfect_hash_function).

> I welcome all improvements via pull-requests :-)

> If you have some comments or suggestions, please contact me at `github@nathanamick.com` - nathan amick

## Goals

We want to transform an integer into another random looking integer and then reliably tranform it back.

It will turn the number `3` into `2356513904`, and it can then reliably reverse that scrambled `2356513904` number back into `3`

We also want sequential integers to become non-sequential.

So for example it will turn `7001, 7002, 7003` into `5270192353, 7107163820, 3296163828`, and back again.

Please note, this is not encryption or related to security in any way.  It lightly obfuscates an integer in a reversable way.

## Usage

Pass a number (as an integer or string) to the 'hash' method and it will return an obfuscated version of it.

    ScatterSwap.hash(1).to_i
    #=> 4517239960

Pass that obfuscated version in and it will return the original (as a zero padded string).

    ScatterSwap.reverse_hash(4517239960).to_i
    #=> 1


*Because this was originally built for urls like this `example.com/users/00000000001` it outputs strings.  This is why the examples above have `to_i` tacked on to them.  Since extracting it to its own library, that may not make sense anymore.  I'm considering output the same type as it is input.  Thoughts?*

## How it works 

This library is built for integers that can be expressed with 10 digits.
It zero pads smaller numbers. 

The number 1 is expressed with:

    0000000001

The biggest number it can deal with is 10 billion - 1:

    9999999999

Since we are working with a limited sequential set of input integers, 10 billion,
this algorithm will suffice for simple id obfuscation for many web apps.

The largest value that Ruby on Rails default id, Mysql INT type, is just over 2 billion (2147483647)
which is the same as 2 to the power of 31 minus 1, but considerably less than 10 billion.

## Strategies

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


## Installation

Add this line to your application's Gemfile:

    gem 'scatter_swap'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scatter_swap

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
