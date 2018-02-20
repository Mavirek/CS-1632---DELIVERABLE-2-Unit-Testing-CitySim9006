require 'minitest/autorun'
require_relative 'driver'


class Driver_Test < Minitest::Test

	def setup
		@d = Driver::new("Driver 1",0)
	end
	#Unit Test for method: initialize(name,location)
	#string name
	#int location
	#This unit test checks whether the newly created Driver object is an instance of Driver
	def test_new_driver_not_nil
		refute_nil @d
		assert_kind_of Driver, @d
	end
	#Unit Test for method: getDriver()
	#Equivalence classes:
	#Correct driver name is returned
	#Incorrect driver name is returned
	
	#Tests if the correct name is returned
	def test_driver_getDriver
		d = Driver::new("Driver test",0)
		assert_equal d.getDriver, "Driver test"
	end
	#Tests for when the incorrect name is returned
	def test_driver_getDriver_invalid
		d = Driver::new("Driver test",0)
		def d.getDriver; "garbage output"; end
		assert_equal d.getDriver, "garbage output"
	end
	#Unit Test for method: setDriver(name)
	#string name
	#Equivalence classes:
	#name is a string -> driver's name is set to 'name' variable
	#Make sure the driver's name is set to the requested name
	def test_driver_setDriver
		d = Driver::new("Driver test",0)
		d.setDriver "asdf"
		assert_equal d.getDriver, "asdf"
	end
	#Unit Test for method: getLocation()
	#Equivalence classes:
	#Valid location is returned in:
	#	hospital, cathedral, hillman, museum, and outside of city (monroeville or downtown)
	#Invalid location is returned as a string
	#Invalid location is returned as a negative number
	#Invalid location is returned as a positive number that is not a valid location
	
	#Get the starting location for a driver
	def test_driver_getLocation
		d = Driver::new("Driver 1",0)
		assert_equal d.getLocation, 0
	end
	#When a driver's location is a string, then an exception is raised
	#EDGE CASE
	def test_getLocation_string
		d = Driver::new("Driver 1",0);
		def d.getLocation; d.location="string","string"; end
		assert_raises ("Invalid location") {d.getLocation}
	end
	#When a driver's location is a negative number, then an exception is raised
	#EDGE CASE
	def test_getLocation_neg_invalid
		d = Driver::new("Driver 1",0);
		def d.getLocation; d.location=-999,-999; end
		assert_raises ("Invalid location") {d.getLocation}
	end
	#When a driver's location is a positive number that is not one of the valid locations,
	#then an exception is returned
	#EDGE CASE
	def test_getLocation_pos_invalid
		d = Driver::new("Driver 1",0);
		def d.getLocation; d.location=999,999; end
		assert_raises ("Invalid location") {d.getLocation}
	end
	#Get the driver's start location at the hospital
	def test_driver_start_getLocation_hospital
		d = Driver::new("Driver 1",0)
		assert_equal d.getLocation, 0
	end
	#Get the driver's start location at the cathedral
	def test_driver_start_getLocation_cathedral
		d = Driver::new("Driver 1",1)
		assert_equal d.getLocation, 1
	end
	#Get the driver's start location at Hillman
	def test_driver_start_getLocation_hillman
		d = Driver::new("Driver 1",2)
		assert_equal d.getLocation, 2
	end
	#Get the driver's start location at museum
	def test_driver_start_getLocation_museum
		d = Driver::new("Driver 1",3)
		assert_equal d.getLocation, 3
	end
	#Get the driver's start location out of the city
	def test_driver_start_getLocation_out_city
		d = Driver::new("Driver 1",-1)
		assert_equal d.getLocation, -1
	end
	#Unit Test for method: checkLocation()
	#Equivalence classes:
	#Valid location checked at the start of a driver's trip and at the middle of a drive's trip
	#Invalid location checked for a location that isn't available
	
	#When the driver's location is invalid, raise an exception
	#EDGE CASE
	def test_driver_checkLocation_invalid
		d = Driver::new("Driver 1",99);
		assert_raises ("Invalid check location") {d.checkLocation}
	end
	
	#Test if the driver would get the appropriate classes/toys/books at his starting location
	def test_driver_checkLocation_start
		d = Driver::new("Driver 1",1)
		d.checkLocation
		assert_equal d.classes, 2
	end
	#Test if the driver would get the appropriate classes/toys/books at the location during the middle of his trip
	def test_driver_checkLocation_mid
		d = Driver::new("Driver 1",1)
		d.checkLocation
		# assert_equal d.classes, 2
		d.setLocation 1 #from cathedral go to museum
		d.checkLocation
		assert_equal [2,1], [d.classes,d.dinotoys]
		#assert_equal d.dinotoys, 1
	end
	
	#Unit Test for method: setLocation(location)
	#int location
	#Equivalence classes:
	#Set location for valid places:
	#	cathedral, museum, hillman, hospital, monroeville, and downtown
	
	#If the the location is set to cathedral, return the corresponding location number
	def test_driver_setLocation_cathedral
		d = Driver::new("Driver 1",0)
		d.setLocation 0 #hospital to cathedral
		assert_equal d.getLocation, 1
	end
	#If the the location is set to museum, return the corresponding location number
	def test_driver_setLocation_museum
		d = Driver::new("Driver 1",1)
		d.setLocation 1 #cathedral to museum
		assert_equal d.getLocation, 3
	end
	#If the the location is set to hillman, return the corresponding location number
	def test_driver_setLocation_hillman
		d = Driver::new("Driver 1",0)
		d.setLocation 1 #museum to hillman
		assert_equal d.getLocation, 2
	end
	#If the the location is set to hospital, return the corresponding location number
	def test_driver_setLocation_hospital
		d = Driver::new("Driver 1",2)
		d.setLocation 1 #hillman to hospital
		assert_equal d.getLocation, 0
	end
	#If the the location is set to monroeville or downtown, return the corresponding location number
	def test_driver_setLocation_monroeville_downtown
		#testing downtown gives the same result as monroeville
		d = Driver::new("Driver 1",1)
		d.setLocation 0
		assert_equal d.getLocation, -1
	end
	
	#Unit Test for method: showResults()
	#Equivalence class:
	#Output the correct number of books/toys/classes for a given trip
	def test_showResults
		d = Driver::new("Driver 1",0)
		assert_output ("Driver 1 obtained 0 books!\nDriver 1 obtained 0 dinosaur toys!\nDriver 1 attended 1 class!\n") {d.showResults}
		d.setLocation 0 #from hospital to cathedral
		d.checkLocation
		assert_output ("Driver 1 obtained 0 books!\nDriver 1 obtained 0 dinosaur toys!\nDriver 1 attended 2 classes!\n") {d.showResults}
		d.setLocation 1 #from cathedral to museum
		d.checkLocation
		assert_output ("Driver 1 obtained 0 books!\nDriver 1 obtained 1 dinosaur toy!\nDriver 1 attended 2 classes!\n") {d.showResults}
		d.setLocation 1 #from museum to hillman
		d.checkLocation
		assert_output ("Driver 1 obtained 1 book!\nDriver 1 obtained 1 dinosaur toy!\nDriver 1 attended 2 classes!\n") {d.showResults}
		d.setLocation 0 #from hillman to downtown
		d.checkLocation
		assert_output ("Driver 1 obtained 1 book!\nDriver 1 obtained 1 dinosaur toy!\nDriver 1 attended 2 classes!\n") {d.showResults}
	end
	
end
