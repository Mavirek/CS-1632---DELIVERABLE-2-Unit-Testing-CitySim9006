class Driver

HOSPITAL,CATHEDRAL,HILLMAN,MUSEUM = 0,1,2,3

ROUTES = [
			["Hospital to Cathedral via Fourth Ave.","Hospital to Hillman via Foo St."],
			["Cathedral to Monroeville via Fourth Ave.","Cathedral to Museum via Bar St."],
			["Hillman to Downtown via Fifth Ave.","Hillman to Hospital via Foo St."],
			["Museum to Cathedral via Bar St.","Museum to Hillman via Fifth Ave."]
		]
		
LOCATIONS = [
				[CATHEDRAL,HILLMAN],
				[-1,MUSEUM],
				[-1,HOSPITAL],
				[CATHEDRAL,HILLMAN]
			]

attr_reader :classes, :books, :dinotoys
		
def initialize name, location
	@name = name
	@location = location #index for 1st dimension of routes[][]
	@classes = 1
	@books = 0
	@dinotoys = 0
end

def setDriver name
	@name = name
end

def getDriver
	@name
end

def setLocation loc
	#puts "loc1 = #{@location} loc2 = #{loc}"
	puts "#{@name} heading from #{ROUTES[@location][loc]}"
	if loc==0 || loc==1
		@location=LOCATIONS[@location][loc]
	else
		raise "Invalid location"
	end
end

def getLocation
	@location
end

def checkLocation
	case @location
	when HILLMAN
		@books += 1
	when MUSEUM
		@dinotoys += 1
	when CATHEDRAL
		@classes *= 2
	when HOSPITAL
	when -1
	else
		raise "Invalid check location"
	end
end

def showResults
	bookString = "#{@books} book"
	bookString.concat("s") unless @books==1
	dinotoyString = "#{@dinotoys} dinosaur toy"
	dinotoyString.concat("s") unless @dinotoys==1
	classString = "#{@classes} class"
	classString.concat("es") unless @classes==1
	puts "#{@name} obtained #{bookString}!"
	puts "#{@name} obtained #{dinotoyString}!"
	puts "#{@name} attended #{classString}!"
end

end
