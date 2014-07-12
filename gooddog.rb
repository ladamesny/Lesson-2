
class GoodDog
	DOG_YEARS = 7
	attr_accessor :name, :age
	@@number_of_dogs = 0 #class variable. We use this to keep track of a class level detail
						 #that pertains only to the class, and not to individual objects.
	#here, we increment the class variable everytime we initialize a new variable.
	def initialize(n,a)
		@@number_of_dogs +=1
		self.name = n
		self.age = a * DOG_YEARS
	end
	def self.total_number_of_dogs #class method
		@@number_of_dogs
	end
	def to_s
		"This dog's name is #{name} and it is #{age} in dog years"
	end
end

#puts GoodDog.total_number_of_dogs # => 0
#dog1 = GoodDog.new
#dog2 = GoodDog.new
#puts GoodDog.total_number_of_dogs # => 2
sparky = GoodDog.new("sparky", 4)
puts sparky.inspect
p sparky