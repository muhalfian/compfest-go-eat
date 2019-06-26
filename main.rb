class Main
	def initialize()
		system "clear" or system "cls"
		args = self.check_arg()
		self.welcome_screen()
		self.init_app(args)
		self.menu()
	end

	def turn_back(ans)
		if ans == 'n'
			puts ""
			puts "*** THANK YOU ***"
			puts ""
			exit(true)
		else 
			system "clear" or system "cls"
			self.menu()
		end
	end

	def init_app(args)
		if args > 1
			@me = Me.new(@@n_map, @@x, @@y)
		else 
			@me = Me.new(@@n_map)	
		end
		@driver = Driver.new(@@n_map)
		@store = Store.new(@@n_map)
		@map = Maps.new(@@name, @me, @driver, @store, @@n_map)
		@order = Order.new(@@name, @me, @driver, @store, @@n_map, @map)
		@db = Database.new(@@name, @me, @driver, @store, @@n_map, @map)
	end

	def check_arg()
		@@n_map = 20

		if ARGV.length > 1
			@@n_map = get_arg("n_map", 0).to_i
			@@x = get_arg("x", 1).to_i
			@@y = get_arg("y", 2).to_i
		end
		ARGV.length
	end

	def get_arg(name,i)
		if ARGV[i].is_i? == false
			puts "#{name} should be integer"
		elsif ARGV[i].to_i == 0
			puts "#{name} cannot be 0"
		end
		ARGV[i]
	end

	def welcome_screen()
		# Welcome Screen
		puts "=" * 50
		print " " * 20
		print "GO-EAT"
		puts " " * 20
		puts "=" * 50

		# Choise
		print "Please enter your name : " 
		@@name = STDIN.gets.chomp
		puts ""
	end

	def menu()
		puts "Welcome #{@@name}, let's order some foods to overcome your hunger"
		puts ""
		puts "1. Show Maps"
		puts "2. Order Food"
		puts "3. History"
		puts ""
		print "Enter your choise : "
		@@choise = Integer(STDIN.gets.chomp) rescue 0
		self.check_not_valid(@@choise)

		case @@choise
		when 1
			system "clear" or system "cls"
			puts ""
			puts "Find Your Self !"
			ans = Integer(@map.generate_maps) rescue 0
			self.turn_back(ans)
		when 2
			system "clear" or system "cls"
			puts ""
			puts "Let's huntiing !"
			ans = Integer(@order.start) rescue 0
			# @db.save(@order)
			self.turn_back(ans)
		when 3
			system "clear" or system "cls"
			puts ""
			puts "*** UNDER MAINTENANCE ***"
			puts ""
			print("Back to Home ? (Y/n) ")
			ans = STDIN.gets.chomp
			self.turn_back(ans)
		when 0
			system "clear" or system "cls"
			puts ""
			puts "*** THANK YOU ***"
			puts ""
		end
	end

	def check_not_valid(i)
		if (i<1 || i>3)
			system "clear" or system "cls"
			self.warning_input()
			self.menu()
		else 
			return i
		end
	end

	def warning_input()
		puts ""
		puts "*** WARNING : Input must be integer (1-3) ***"
		puts ""
	end
end



class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

load 'driver.rb'
load 'maps.rb'
load 'me.rb'
load 'store.rb'
load 'order.rb'
load 'database.rb'

Main.new