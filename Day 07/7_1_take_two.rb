#!/usr/bin/ruby

words = []

File.readlines('day_7_input.txt').each do |line|
	words << line.split(" ")	
end

comes_before = []
comes_after = []

words.each do |line|

	comes_before << [line[1], line[7]]
	comes_after << [line[7], line[1]]
	comes_after.sort!
	
end

sorted = []
options = ["option"]


p comes_before

