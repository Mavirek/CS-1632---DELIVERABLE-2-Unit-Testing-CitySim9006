require_relative 'driver'

raise "Enter a seed and only a seed" unless ARGV.count == 1
seed = ARGV[0].to_i
rnd = Random::new seed
drivers = [Driver.new("Driver 1", rnd.rand(4)),Driver.new("Driver 2", rnd.rand(4)),Driver.new("Driver 3", rnd.rand(4)),Driver.new("Driver 4", rnd.rand(4)),Driver.new("Driver 5", rnd.rand(4))]

for driver in drivers do
	while driver.getLocation != -1
		driver.checkLocation
		driver.setLocation rnd.rand(2)
	end
	driver.showResults
end
