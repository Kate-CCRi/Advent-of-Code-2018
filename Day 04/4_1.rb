#!/usr/bin/ruby

# Get the input file
input = File.read("day_4_test.txt")

# Make a new array called "logs" that has the text from "input" split on the newline character (which conveniently makes that character go away)
logs = input.split("\n").sort

# Note that the .inspect tag forces it to show you the actual structure of your array, not just the contents.
puts logs.inspect

=begin
Sort the list into time order. Note that not all times start with 00.
Create a nested array like so:
[
	Day
	[
		Guard
		[
		0..59
		]
	]
]

times = Array.new
	
If the first item in the line after the time is "Guard", go to that line in the array.
Then:
	If the first item in the next line after the time is "falls", put the minutes in that timestamp into a "marked" array.
	If the first item in the line after the time is "wakes", put (the minute - 1) in that timestamp into the "marked" array AND
	Mark the cells in the range of the "marked" array as "asleep".
=end