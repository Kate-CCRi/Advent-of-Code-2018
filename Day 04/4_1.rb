#!/usr/bin/ruby

require 'rubytree'
require 'tree'

# Get the input file
input = File.read("day_4_test.txt")

# Make a new array called "logs" that has the text from "input" split on the newline character (which conveniently makes that character go away). This also automatically sorts it into the proper day/time order.

logs = input.split("\n").sort

# Set up a new array called "guard_logs"
guard_logs = []

# Set up a new hash called "real_log" that is expecting arrays to go with its keys
real_log = Hash.new{|hsh, key| hsh[key] = []}

# Go through the input and put the first four items of each record into a separate array (removing the [] as you go)

logs.each do |record|
	solo_logs = record.delete("[").delete("]").split	
	solo_logs.each_slice(4) {|slice| guard_logs << slice}
end

# Iterate through the log file
guard_logs.each do |entry|

# The 4 slice causes some entries in guard_logs of ["begins", "shift"] so this checks for those and ignores them.

	if entry[0] != "begins"
		
		# This block puts the date, time, activity, and guard number (if there is one) into the appropriate variables
		date = entry[0]
		time = entry[1].delete(":")
		activity = entry[2]
		
		if entry[3].start_with?("#")
			number = entry[3].delete("#")
		else
			number = nil
		end
		
		# Use different holder variables based on whether the record is for a guard or an activity.
		if number == nil
			temp = [time, activity]	
		else
			guard_temp = [time, activity, number]
		end
		
		# This pushes whatever exists into the hash for the current date.
		if number == nil
			real_log[date].push temp
		else
			real_log[date].push guard_temp
		end
	end
end


# This block goes through the hash and pulls any shift changes from before midnight into the appropriate day.

temp_guard = []

real_log.each do |date, record|

	# This ordering is very important -- if you put the first block second, it puts the pre-midnight guard information into every record!
	
	if temp_guard.include?("Guard")
		# Puts the guard information into the record array as the *first* element.
		record.unshift(temp_guard)
		# Empties the temp_guard array now that we've placed that information.
		temp_guard = []
	end

	if record.last.include?("Guard")
		# pop pulls the last item out of an array permanently and returns that item.
		temp_guard = record.pop
	end
end

# Ugh, this comment is wrong, FIXIT
# Initializes the array to hold the Guard information - Level 1 = Guard, Level 2 = Minute, Level 3 = times seen

info = Hash.new
sleeptime = 0
gname = ""

outer_run = 0
inner_run = 0

real_log.each do |date, entry|

puts date.inspect
puts entry.inspect


	entry.each do |record|
	
		time = record[0].to_i
		activity = record[1]
	
		if activity == "Guard"
			# Only set the "gname" variable if the record is for a guard coming on shift
			gname = "#{record[1]} #{record[2]}"
			# Check to see if this Guard already exists
			if info.key?(activity)
				next
			# If not, create a new hash entry for that guard which contains a new array of 60 zeroes to represent the minutes
			else
				info[gname] = Array.new(60, 0)
			end
		end
		
		# Since the sorting makes it so that "falls" always comes before "wakes", we can set this variable here and use it in the next round.
		if activity == "falls"
			sleeptime = time
		end
		
		# Here's where it gets interesting.
		if activity == "wakes"
			waketime = time - 1
			
			min_array = info[gname]

			for i in sleeptime..waketime do
				min_array[i] = min_array[i] + 1
				
			end
		end	
		inner_run += 1
		puts inner_run		
	end
	
	outer_run += 1
	puts outer_run	
end

puts info.inspect
