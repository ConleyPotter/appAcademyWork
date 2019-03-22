require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)!
 Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject { Dessert.new("brownie", 10, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(subject.type).to eq("brownie")
    end

    it "sets a quantity" do 
      expect(subject.quantity).to eq(10)
    end

    it "starts ingredients as an empty array" do 
      expect(subject.ingredients).to be_empty
    end
    
    it "raises an argument error when given a non-integer quantity" do
      expect{ Dessert.new("brownie", "string", chef) }.to raise_error(ArgumentError)
    end
  end


  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do 
      subject.add_ingredient("milk")
      expect(subject.ingredients).to include("milk")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      expect(subject.mix!).to eq(subject.ingredients.shuffle)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      subject.eat(1)
      expect(subject.quantity).to eq(9)
    end
    it "raises an error if the amount is greater than the quantity" do
      expect { subject.eat(11) }.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Chef Boyardi The Great Baker")
      expect(subject.serve).to include(chef.titleize)
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(subject).and_return(400)
    end
  end
end
