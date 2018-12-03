#!/usr/bin/ruby

# Set up a variable, an array, and a hash  
current = 0  # current state
inputs = []  # input array
seen = {}    # seen values

# read input
f = File.open("day_1_input.txt")
while line = f.gets do
    inputs << line.to_i
end

while (true) do  # iterate over the input sequence forever
    inputs.each do |x|  # process each item in the input sequence
        current = current + x  # update the current value 
        puts "permutation #{x} -> #{current}"
        if seen.has_key?(current)  # check if we've seen this value before
            puts "You are looking for #{current}"
            exit
        end
        seen[current] = seen # adds a value in the hash for the using current as the key
    end
end