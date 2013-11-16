#Kevin Welsh
#CIS 343 Programming Languages
#Project 5, Ruby Reflection
#April 8, 2011

#Main Project 5 class
class P
	#empty class, do I even need this?
	#Possibly put the main method in here
	#And call it like P.main() or something?
end

#main class
def main
	
	choice = 'y'

	while choice == 'y'

		#before = Module.constants
		file = nil
		isLoaded = false

		while isLoaded==false
			#Exception Handling for File Loading
			begin
				before = Module.constants
				#File Loading Code		
				puts "Type name of file to inspect\n"
				file = Dir.getwd + "/" + readline.chop!		
				puts "\nFile Name: #{file} \n"
				require(file)
				isLoaded=true
			rescue LoadError
				puts "\n*ERROR: LoadError occured during file load\n"
				puts "Cannot load file\n"
				puts "Please try again\n\n"
				isLoaded=false
			end #begin

		end #while	
	
		#Makes Hash with each type in the file
		map = Hash.new
		count = 0
		types = Module.constants - before
		puts "File has the following types: \n"

		#Exception Handling for an odd reoccuring error
		begin
			types.each do |type|
				count = count + 1
				t = Module.const_get(type)
				map[count]=t
				puts("	#{count}: #{map[count].name}\n")			
		
			end #do
		rescue NoMethodError
			puts "\n*ERROR: NoMethodError occured during Type Inspection\n"
			puts "Cause is unknown\n"
			puts "Exiting...\n\n"
			exit
		end #begin

		c = 'y'
		puts "\n\nDo you want to examine a type? (y/n)"
		c = readline.chop!		
		r=0		

		#Evaluates the type
		while c=='y'
			puts "\nEnter the number of the type to examine\n"
			r = readline.chop!
			if (r.to_i<=count && r.to_i>0)

				print "\n"

				puts "	Type Entered: #{map[r.to_i]} \n"			
	
				puts("	Super Class: #{map[r.to_i].superclass}\n") if map[r.to_i].kind_of?(Class)

				puts("	Ancestors: #{map[r.to_i].ancestors}\n")
	
				puts("	Included Modules: #{map[r.to_i].included_modules}\n")
		
				puts("	Constants: #{map[r.to_i].constants(false)}\n")
	
				puts("	Class Variables: #{map[r.to_i].class_variables}\n")
	
				puts("	Class Methods: #{map[r.to_i].singleton_methods(false)}\n")

				puts("	Instance Methods: #{map[r.to_i].instance_methods(false)}\n")
	
				puts("	Public Instance Methods: #{map[r.to_i].public_instance_methods(false)}\n")
	
				puts("	Protected Instance Methods: #{map[r.to_i].protected_instance_methods(false)}\n")
	
				puts("	Private Instance Methods: #{map[r.to_i].private_instance_methods(false)}")
	
				print("\n")				

			else
				puts("\n*ERROR: Invalid Number\n") 
				puts("Try Again\n\n")
		
			end #if

			puts "Do you want to choose another type? (y/n)\n"
			c = readline.chop!

		end #while
		
		puts "\nContinue with another file? (y/n)\n"
		choice = readline.chop!

	end

	puts "\nBye...\n"

end

#Call main function
main()
