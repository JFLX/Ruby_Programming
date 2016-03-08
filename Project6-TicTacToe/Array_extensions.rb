class Array
	def all_same?
		self.all? { |x| x == self[0] }
	end
	def all_empty?
		self.all? { |x| x.empty? }
	end
	def any_empty?
		self.any? { |x| x.empty? }
	end
	def none_empty?
		!any_empty?
	end
end