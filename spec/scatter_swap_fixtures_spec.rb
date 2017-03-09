require 'spec_helper'
require 'scatter_swap'
require 'json'

describe "ScatterSwap Known Examples" do
    fixtures_file = File.read('spec/fixtures/scatter_swap_fixtures.json')
    fixtures = JSON.parse(fixtures_file)

    describe 'hash and reverses' do
        it 'hashes and reverse hashes known values predictably' do
            fixtures.each do |fixture_group|
                spin = fixture_group['spin']
                hasher = ScatterSwap::Hasher.new(spin)
                fixture_group['examples'].each do |example|
                    plain_id = example[0]
                    obfuscated_id = example[1]
                    expect(hasher.hash(plain_id).to_i).to eq(obfuscated_id)
                    expect(hasher.reverse_hash(obfuscated_id).to_i).to eq(plain_id)
                end
            end
        end
    end
end
