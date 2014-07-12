#mycar.#!/usr/bin/env ruby -wKU

class MyCar
	attr_accessor :color,:speed, :model
	attr_reader :year

	def initialize(yr, color, model)
		@year = yr
		@color = color
		@model = model
		@speed = 0
	end

	def speed_up(speed)
		self.speed +=speed
		puts "You push the gas and accelerate #{speed} mph."
	end

	def brake(speed)
		self.speed -= speed
		puts "You push the brake and decelerate #{speed} mph"
	end

	def shut_off
		self.speed = 0
		puts "Let's park this baby!"
	end
	def current_speed
		puts "Your current speed is #{speed} mph"
	end
	def spray_paint(color)
		self.color = color
	end

	def self.MPG(gallons, miles)
		puts "#{miles/gallons} miles per gallon of gas"
	end
	def to_s
		"A #{self.color} #{self.year} #{self.model}"
	end

end

BMW = MyCar.new("2007", "Silver", "335i")

BMW.speed_up(20)
BMW.current_speed
BMW.speed_up(20)
BMW.current_speed
BMW.brake(20)
BMW.current_speed
BMW.brake(20)
BMW.current_speed
BMW.shut_off
BMW.current_speed
BMW.spray_paint("Yellow")
puts BMW.color
puts "#{BMW}"