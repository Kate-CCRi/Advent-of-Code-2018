#!/usr/bin/env ruby

require 'set'

# An array to hold our lines that we're about to read in
input = []

# Get the input file
f = File.open("day_3_input.txt")

# Read each line of the file and put its value into the array
while line = f.gets do
	input << line
end	

grid = Array.new(1000) { Array.new(1000) { Set.new } }
candidates = Set.new

input.each do |claim|
  id, claim = claim.split("@")
  ord, dim = claim.split(":")
  x, y = ord.split(",").map(&:to_i)
  w, h = dim.split("x").map(&:to_i)
  id = id[1..-1].to_i

  candidates.add id

  w.times do |x1|
    h.times do |y1|
      cell = grid[x+x1][y+y1]

      if cell.any?
        candidates.delete id

        cell.each do |c|
          candidates.delete c
        end
      end

      cell.add id
    end
  end
end

puts candidates.to_a