require 'rspec'
require_relative '../lib/practice_test'
describe "prime_factorization" do
  it "handles an input of 2" do
    expect(prime_factorization(2)).to eq([2])
  end

  it "correctly calculates the prime factorization of a number" do
    expect(prime_factorization(12).sort).to eq([2,2,3])
  end

  it "correctly calculates the prime factorization of a large number" do
    expect(prime_factorization(600851475143).sort).to eq([71,839,1471,6857])
  end
end

describe "deep_dup" do
  subject(:robot_parts) do [
      ["nuts", "bolts", "washers"],
      ["capacitors", "resistors", "inductors"]
    ]
  end
  let(:copy) { deep_dup(robot_parts) }

  it "makes a copy of the original array" do
    expect(copy).to eq(robot_parts)
    expect(copy).not_to be(robot_parts)
  end

  it "deeply copies arrays" do
    expect(copy[0]).to eq(robot_parts[0])
    expect(copy[0]).not_to be(robot_parts[0])

    copy[1] << "LEDs"
    expect(robot_parts[1]).to eq(["capacitors", "resistors", "inductors"])
  end
end

describe "#median" do
  let(:even_array) { [3, 2, 6, 7] }
  let(:odd_array) { [3, 2, 6, 7, 1] }

  it "returns nil for the empty array" do
    expect([].median).to be_nil
  end

  it "returns the element for an array of length 1" do
    expect([1].median).to eq(1)
  end

  it "returns the median of an odd-length array" do
    expect(odd_array.median).to eq(3)
  end

  it "returns the median of an even-length array" do
    expect(even_array.median).to eq(4.5)
  end
end

describe "titleize" do
  it "capitalizes a word" do
    expect(titleize("jaws")).to eq("Jaws")
  end

  it "capitalizes every word (aka title case)" do
    expect(titleize("david copperfield")).to eq("David Copperfield")
  end

  it "doesn't capitalize 'little words' in a title" do
    expect(titleize("war and peace")).to eq("War and Peace")
  end

  it "does capitalize 'little words' at the start of a title" do
    expect(titleize("the bridge over the river kwai")).to eq("The Bridge over the River Kwai")
  end
end

describe 'Array#my_inject' do

  it "should use #my_each, NOT built-in ruby method" do
    arr = [1, 2, 3]
    expect(arr).to receive(:my_each).and_call_original
    expect(arr).not_to receive(:each)
    expect(arr).not_to receive(:map)
    expect(arr).not_to receive(:map!)
    arr.my_inject(1) { |acc, x| acc + x }
  end

  it 'calls the block passed to it' do
    expect do |block|
      ["test array"].my_inject(:dummy, &block)
    end.to yield_control.once
  end

  it 'makes the first element the accumulator if no default is given' do
    expect do |block|
      ["el1", "el2", "el3"].my_inject(&block)
    end.to yield_successive_args(["el1", "el2"], [nil, "el3"])
  end

  it 'yields the accumulator and each element to the block' do
    expect do |block|
      [1, 2, 3].my_inject(100, &block)
    end.to yield_successive_args([100, 1], [nil, 2], [nil, 3])
  end

  it 'does NOT call the built in Array#inject or Array#reduce method' do
    original_array = ["original array"]
    expect(original_array).not_to receive(:inject)
    expect(original_array).not_to receive(:reduce)
    original_array.my_inject {}
  end

  it 'with accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject(1) { |acc, x| acc + x }).to eq(7)
    expect([3, 3].my_inject(3) { |acc, x| acc * x }).to eq(27)
  end

  it 'without accumulator, it correctly injects and returns answer' do
    expect([1, 2, 3].my_inject { |acc, x| acc + x }).to eq(6)
    expect([3, 3].my_inject { |acc, x| acc * x }).to eq(9)
  end
end

describe "my_each" do
  res = []
  [1,2,3].my_each{|el| res << 2*el}

  it "It works for blocks" do
    expect(res).to eq([2,4,6])
  end
end

describe "my_each_with_index" do
  res = []
  [1,2,3].my_each_with_index{|el, i| res << 2*el + i}

  it "It works for blocks that use both the index and element" do
    expect(res).to eq([2,5,8])
  end
end

describe 'my_any' do
  arr = [1,2,3]

  it "should use #my_each, NOT built-in ruby method" do
    expect(arr).to receive(:my_each).and_call_original
    expect(arr).not_to receive(:each)
    expect(arr).not_to receive(:map)
    expect(arr).not_to receive(:map!)
    arr.my_any? { |num| num > 1 }
  end

  it "returns true if any number matches the block" do
    expect(arr.my_any? { |num| num > 2 }).to eq(true)
  end

  it "returns false if no elementes match the block" do
    expect(arr.my_any? { |num| num == 4 }).to eq(false)
  end
end

describe "#jumble_sort" do
  it "defaults to alphabetical order" do
    expect(jumble_sort("hello")).to eq("ehllo")
  end

  it "takes an alphabet array and sorts by that order" do
    alph = ("a".."z").to_a
    hello = "hello".chars.uniq
    alph -= hello
    alphabet = (hello += alph)

    expect(jumble_sort("hello", alphabet)).to eq("hello")
  end

  it "sorts by a reversed alphabet" do
    reverse = ("a".."z").to_a.reverse
    expect(jumble_sort("hello", reverse)).to eq("ollhe")
  end

  it "works with an empty string" do
    expect(jumble_sort("")).to eq("")
  end

  it "works with a string of one item" do
    expect(jumble_sort("g")).to eq("g")
  end
end
