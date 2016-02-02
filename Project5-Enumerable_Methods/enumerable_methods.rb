module Enumerable
	def my_each
		for element in self
			yield(element)
		end
		self
	end
	def my_each_with_index
		i = 0
		self.my_each {|element| yield(element, index); index += 1}
		self
	end
	def my_select
		result = []
		self.my_each {|element| result << element if yield(element)}
		result
	end
	def my_all?
		self.my_each {|element| return false unless yield(element)}
		true
	end
	def my_any?
		self.my_each {|element| return true if yield(element)}
		false
	end
	def my_none?
		self.my_each{|element| return false if yield(element)}
		true
	end
	def my_count
		count = 0
		self.my_each do |element|
			count += 1 if (block_given? && yield(element)) || !block_given?
		end
		count
	end
=begin
	#my_map take a block
	def my_map
		result = []
		self.my_each {|element| result << yield(element)}
		result
	end
	#my_map take a Proc
	def my_map
		result = []
		self.my_each {|element| result << proc.call(element)}
		result
	end
=end
	def my_map(proc=nil)
		result =[]
		if block_given? && proc
			self.my_each {|element| result << proc.call(yield(element))}
		elsif proc
			self.my_each {|element| result << proc.call(element)}
		else
			return self
		end
		result
	end
	def my_inject(initial_value=nil)
		result = initial_value
		self.my_each do |element| 
			if result.nil?
				result = self[0]
			else
				result = yield(result, element)
			end
		end
		result
	end
end
def multiply_els(array)
	array.my_inject {|prod,number| prod * number}
end