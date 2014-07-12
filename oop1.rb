class Animal
  attr_accessor :name, :height, :weight
  @@count = 0
  def initialize (n, h, w)
  @name = n
  @height = h
  @weight = w
  @@count +=1 
  end
  def self.total_dogs
    "You have #{@@count} dogs!"
  end

  def speak
    @name + " barks!"
  end
  def update_info (n,h,w)
    self.name = n
    self.height = h
    self.weight = w
  end
  def info
    "#{name} is #{height} feet tall and weighs #{weight} pounds!" #it looks for accessing getter method for each of these
  end
end

class Mammal < Animal
  def warm_blooded?
    true
  end
end
module Kanine
  def swim
    "#{name} is swimming!"
  end
  def fetch
    "#{name} is fetching!"
  end
end

class Dog < Mammal
  include Kanine
  
end
class Cat < Mammal
  def speak
    "#{name} is meowing!"
  end

end

Chachi = Dog.new('Chachi', 2, 30)
Woody = Dog.new("Woody", 3, 40)
Zorro = Cat.new("Zorro", 1, 5)
# puts Chachi.name
# puts Chachi.height
# puts Chachi.weight
# Chachi.update_info("Roosevelt", 3, 32) 
# puts Chachi.weight
# puts Dog.total_dogs
# puts Zorro.speak
# puts Chachi.fetch
# puts Dog.ancestors
puts Chachi.swim
puts Chachi.fetch