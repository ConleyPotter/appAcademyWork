require 'rspec'
require_relative '../lib/practice_test_09'
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

describe "exponent" do
  it "returns the correct answer for positive exponents" do
    expect(exponent(5,3)).to eq(125)
  end

  it "returns the correct answer for negative exponents" do
    expect(exponent(2, -3)).to eq(1/8.0)
  end

  it "returns the correct answer when n is 0" do
    expect(exponent(2, 0)).to eq(1)
  end

  it "calls itself recursively" do
    expect(self).to receive(:exponent).at_least(:twice).and_call_original
    exponent(2, 3)
  end
end
describe "#rec_sum" do
  it "returns the sum of all elements in an array" do
    arr = [1,2,3,4]
    expect(rec_sum(arr)).to eq(10)
  end

  it "returns the sum of all elements in an array" do
    expect(rec_sum([-6, 6, 5, 4])).to eq(9)
  end
  
  it "returns 0 if the array is empty" do
    expect(rec_sum([])).to eq(0)
  end

  it "calls itself recursively" do
    expect(self).to receive(:rec_sum).exactly(4).times.and_call_original
    rec_sum([1,2,3])
  end
end
describe "#digital_root" do
  it "calculates the digital root of a single-digit number" do
    expect(digital_root(9)).to eq(9)
  end

  it "calculates the digital root of a larger number" do
    expect(digital_root(4322)).to eq(2)
  end

  it "does not call #to_s on the argument" do
    expect_any_instance_of(Integer).to_not receive(:to_s)
    digital_root(4322)
  end
end

describe 'first_even_numbers_sum' do
  it "returns the sum of the first even number" do
    expect(first_even_numbers_sum(1)).to eq(2)
  end

  it "returns the sum of the first n even numbers" do
    expect(first_even_numbers_sum(6)).to eq(42)
  end

  it "calls itself recursively" do
    expect(self).to receive(:first_even_numbers_sum).at_least(:twice).and_call_original
    first_even_numbers_sum(6)
  end
end
describe 'fibs_sum' do
  it 'returns the sum of the first fibonacci number' do
    expect(fibs_sum(1)).to eq(1)
  end

  it 'returns the sum of the first 2 fibonacci numbers' do
    expect(fibs_sum(2)).to eq(2)
  end

  it 'returns the sum of the first 6 fibonacci numbers' do
    expect(fibs_sum(6)).to eq(20)
  end

  it "calls itself recursively" do 
    expect(self).to receive(:fibs_sum).at_least(:twice).and_call_original
    fibs_sum(6)
  end
end
describe "string_include_key" do
  it "returns true for the same string" do
    expect(string_include_key?("adblfci", "abc")).to eq(true)
  end

  it "handles keys with duplicate characters: case 1" do
    expect(string_include_key?("adbblfci", "abbc")).to eq(true)
  end

  it "handles keys with duplicate characters: case 2" do
    expect(string_include_key?("adbclfci", "abbc")).to eq(false)
  end

  it "returns false if the key characters are in the wrong order" do
    expect(string_include_key?("dblfcia", "abc")).to eq(false)
  end

  it "returns false if the string doesn't contain the key" do
    expect(string_include_key?("db", "abc")).to eq(false)
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

describe "#factorials_rec" do
  it "returns first factorial number" do
    expect(factorials_rec(1)).to eq([1])
  end

  it "returns first two factorial numbers" do
    expect(factorials_rec(2)).to eq([1, 1])
  end

  it "returns many factorials numbers" do
    expect(factorials_rec(6)).to eq([1, 1, 2, 6, 24, 120])
  end

  it "calls itself recursively" do
    expect(self).to receive(:factorials_rec).at_least(:twice).and_call_original
    factorials_rec(6)
  end
end
