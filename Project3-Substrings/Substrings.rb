def substrings(text, array)
	hash = Hash.new(0)
	strings = text.downcase.split(/\W/)
	array.each do |substring|
		value = 0
		strings.each do |word|
			if word.include?(substring)
				value += 1
				hash[substring] = value
			end
		end
	end
	hash.sort_by {|keys, values| keys}
	hash
end
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
puts "Enter a message:"
message = gets.chomp
puts "Enter words to look for in the message separated by commas:"
words = gets.chomp.split(",")
puts substrings(message, words)
