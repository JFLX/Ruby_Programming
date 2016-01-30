def bubble_sort_by(array)
	i = 0
	(array.length - 1).times do
		while i < (array.length - 1)
			if yield(array[i], array[i + 1]) > 0
				array.swap!(i, i + 1)
			end
			i += 1
		end
		i = 0
	end
	puts "#{array}"
end
class Array
	def swap!(index1, index2)
		self[index1], self[index2] = self[index2], self[index1]
	end
end

bubble_sort_by(["hi","hello","hey"]) do |left,right|
	left.length - right.length
end