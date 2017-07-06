require_relative "../lib/enumerable_methods.rb"

describe "My Enumerable Methods" do

	let(:array){(1..5).to_a}

	describe "#my_each" do 
		it "enumerates through an array yielding to a block" do 
			expect(array.my_each {|i| i}).to eq(array)
		end
	end

	describe "#my_select" do 
		it "enumerates through and selects true valued items" do 
			expect(array.my_select {|i| i > 2}).to eq([3,4,5])
		end
	end

	describe "#my_all" do 
		context "not given a block" do
			it "returns true if all values are 'truthy'" do
				expect(array.my_all?).to eq(true)
			end
		end

		context "given a block" do 
			it "returns true if all values pass block condition" do 
				expect(array.my_all? {|i| i.is_a? Integer}).to eq(true)
			end
		end 
	end

	describe "#my_count" do 
		context "no argument or block" do 
			it "counts all elements" do 
				expect(array.my_count).to eq(5)
			end 

		context "argument given"
			it "counts number of values equal to argument" do 
				expect(array.my_count(5)).to eq(1)
			end
		end

		context "block given" do 
			it "counts number of true values of block" do
				expect(array.my_count {|i| i > 3}).to eq(2) 
			end
		end
	end

	describe "#my_map" do

		let(:my_proc) {proc {|i| i + 1} } 
		context "if no block or proc given" do 
			it "returns an enumerator" do
				expect(array.my_map).to be_a(Enumerator)
			end
		end 

		context "if a block is given" do
			it "returns an array resulting from running the block for each element" do
				expect(array.my_map {|i| i + 1}).to eq([2,3,4,5,6])
			end
		end

		context "if a proc is given" do 
			it "does the same thing as a block" do 
				expect(array.my_map &my_proc).to eq([2,3,4,5,6])
			end
		end
	end

	describe "#my_inject" do 
		context "no argument given" do 
			it "starts at the begining and applies the block" do 
				expect(array.my_inject {|tot, i| tot + i}).to eq(15)
			end
		end
		context "argument given" do 
			it "starts at the given position the applies the block" do 
				expect(array.my_inject(1) {|tot, i| tot + i}).to eq(14) 
			end
		end
	end
end