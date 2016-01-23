def caesar_cipher (text, key)
	#array from a to z with index 0 to 25
	alphabet = ("a".."z").to_a
	#Report the key to a number between 0 and 26
	key %= 26
	#Store each characters of the text in an array
	characters = text.split("")
	#For each character of the array first we find the index of the letter in the alphabet array, then add 1 because the array is index based 0 and then we add the key
	crypted_characters = characters.map do |char|
		#Make sure every letter is lowercase
		letter = char.downcase
		#Check if the character is a letter
		if alphabet.include?(letter)
			#Change letter to it's index by checking it's index in the alphabet array then add the key
			number = alphabet.index(letter) + key
			#Number over 26 should restart at 1
			if number > 26
				number -= 26
			end
			#With the crypted number, find the crypted letter of the alphabet corresponding to this index
			crypted = alphabet[number]
			#Check if the original character was upcase and set the crypted letter accordingly
			if char == char.upcase
				crypted.upcase!
			end
			crypted
		#If the character is not a letter just return the character
		else
			char
		end
	end
	#Join the crypted characters to obtain the crypted string
	crypted_string = crypted_characters.join
end

puts "Enter the message encrypt:"
message = gets.chomp
puts "Enter the key to encrypt the message:"
key = gets.chomp.to_i
puts "This is your encrypted message: " + caesar_cipher(message, key)
