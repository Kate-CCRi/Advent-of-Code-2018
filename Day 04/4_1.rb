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

puts real_log.inspect

# Time for a new approach.

=begin

Pseudocode:

Make a nested array [Guard[Minute Number[Times Seen]]] <-- this should be a hash with arrays in it so that you don't have to worry about duplicating guards

TODO: FIX

For each day
	Find the guard that's on duty.
	Find the time he went to sleep.
	Find the time he woke up.
	Calculate the number of minutes he was asleep.
	Go to the minute he went to sleep.
	From that minute .times do
		increment the times seen <-- I had some cute code for this, I need to find it
End
=end

# Initializes the array to hold the Guard information - Level 1 = Guard, Level 2 = Minute, Level 3 = times seen

info = Hash.new
sleeptime = 0
gname = ""

real_log.each do |date, entry|

	entry.each do |record|
	
		time = record[0].to_i
		activity = record[1]
		count = 0
	
		if activity == "Guard"
			# Only set the "gname" variable if the record is for a guard coming on shift
			gname = "#{record[1]} #{record[2]}"
			# Check to see if this Guard already exists
			if info.key?(activity)
				next
			# If not, create a new hash entry for that guard which contains a new hash using the minute number as the key and the number of times you've seen it as the value
			else
				info[gname] = {0 => count}
			end
		end
		
		if activity == "falls"
			sleeptime = time
		end
		
		if activity == "wakes"
			waketime = time
			time_asleep = waketime - sleeptime
			 
			info.each do |guard, minutes| 
				if guard = gname
					minutes.each do |time, seen|
						if minutes.key?(sleeptime)
							seen +=1
						else
							minutes[sleeptime] = 1
						end
					end
				end
			end
		end
	end
end

puts info.inspect
