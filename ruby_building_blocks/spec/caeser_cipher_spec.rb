require_relative "../lib/caesar_cipher"

describe "The Caesar Cipher" do
  context "given a string and shift number" do 
	it "given 1 it shifts each letter by 1" do 
	  expect(cipher("hi", 1)).to eq("ij")
	end

	it "ignores white space" do
	  expect(cipher("hi hi", 1)).to eq("ij ij")
	end

	it "wraps around z" do
	  expect(cipher("z", 1)).to eq("a")
	end

	it "persists capital letters" do 
	  expect(cipher("AaA BbBB", 1)).to eq("BbB CcCC")
	end

  end
end