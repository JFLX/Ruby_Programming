def bubble_sort(array)
	i = 0
	(array.length - 1).times do
		while i < (array.length - 1)
			if left_is_bigger?(array[i], array[i + 1])
				array.swap!(i, i + 1)
			end
			i += 1
		end
		i = 0
	end
	puts "#{array}"
end

def left_is_bigger?(num1, num2)
	comparison = num1 <=> num2
	if comparison == 1
		true
	else
		false
	end
end
class Array
	def swap!(index1, index2)
		self[index1], self[index2] = self[index2], self[index1]
	end
end
bubble_sort([4,3,78,2,0,2])
