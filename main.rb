require_relative './db/config'
require_relative './app/models/legislator'


# Given any state, first print out the senators for that state (sorted by last name), 
# then print out the representatives (also sorted by last name). 
# Include the party affiliation next to the name. The output might look something like this:

# Senators:
#   Barbara Boxer (D)
#   Diane Feinstein (D)
# Representatives:
#   Xavier Becerra (D)
#   Howard L. Berman (D)
#   Brian P. Bilbray (R)
#   (... etc., etc., ...)
#   Diane E. Watson (D)
puts
puts

senators = Legislator.where("state = ? and title = ?", "TX", "Sen" )
reps = Legislator.where("state = ? and title != ?", "TX", "Sen" )

puts "Senators"
senators.each do |senator|
  name = senator.full_name
  letter = senator.title[0]

  puts " #{name} (#{letter})"
end


puts "representatives"
reps.each do |rep|
  name = rep.full_name
  letter = rep.title[0]

  puts " #{name} (#{letter})"
end

puts
puts

# Given a gender, print out what number and percentage of the senators are of that gender 
# as well as what number and percentage of the representatives, 
# being sure to include only those congresspeople who are actively in office, e.g.:

# Male Senators: 83 (83%)
# Male Representatives: 362 (83%)

senators = Legislator.where("title = ?", "Sen")
p total_senators = senators.count
male_senators = Legislator.where("title = ? and gender = ?",'Sen', 'M').count
percentage = male_senators*100/total_senators

puts "Male Senators: #{percentage}"

reps = Legislator.where("state = ? and title != ?", "TX", "Sen" )
total_reps = reps.count
male_reps = Legislator.where("title = ? and gender = ?",'Sen', 'M').count
percentage = male_reps*100/total_reps

puts "Male Representatives: #{percentage}"


puts
puts

# Print out the list of states along with how many active senators and representatives are in each, 
# in descending order (i.e., print out states with the most congresspeople first).

# CA: 2 Senators, 53 Representative(s)
# TX: 2 Senators, 32 Representative(s)
# NY: 2 Senators, 29 Representative(s)
# (... etc., etc., ...)
# WY: 2 Senators, 1 Representative(s)
active_reps = Legislator.where("in_office = ? and title = ?", true, "Rep").count(:group=>"state")
sorted_reps = active_reps.sort_by{|k,v| v}.reverse

active_senators = Legislator.where("in_office = ? and title = ?", true, "Sen").count(:group=>"state")
sorted_senators = active_senators.sort_by{|k,v| v}.reverse

sorted_senators.each_with_index do |rep, i|
  rep = sorted_reps[i]
  puts "#{rep[0]}: #{rep[1]} Senators, #{rep[1]} Representatives"
end

puts
puts


# For Senators and Representatives, count the total number of each 
# (regardless of whether or not they are actively in office).

# Senators: 137
# Representatives: 603
active_legislators = Legislator.count(:group=>"title")
active_sen = active_legislators.select{|k, v| k == "Sen"}
active_reps = active_legislators.select{|k, v| k != "Sen"}

puts "Senators: #{active_sen["Sen"]}"
puts "Representatives: #{active_reps.values.reduce(:+)}"
puts


# Now use ActiveRecord to delete from your database any congresspeople who are not actively in office, 
# then re-run your count to make sure that those rows were deleted.

# Senators: 100
# Representatives: 435
active_legislators = Legislator.where("in_office = ?", true).count(:group=>"title")
active_sen = active_legislators.select{|k, v| k == "Sen"}
active_reps = active_legislators.select{|k, v| k != "Sen"}

puts "Senators: #{active_sen["Sen"]}"
puts "Representatives: #{active_reps.values.reduce(:+)}"
puts
