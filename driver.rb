class Driver
	attr_reader :positions, :symbol, :ratings, :name

	def initialize(n_map, n_driver=5)
		@@n_driver =  n_driver
		@@n_map = n_map
		
		@symbol = " 8"
		@name = Array.new(@@n_driver) {|i| {"name" => "Driver " + (i+1).to_s}}
		@ratings = Array.new(@@n_driver) { [] }
		@positions = Array.new(@@n_driver) {{ "x" => (rand @@n_map), "y" => (rand @@n_map) }}
	end

	def give_rating(driver_id)
		system "clear" or system "cls"
		puts ""
		print "please give rating to driver (1-5) : "
		rating = Integer(STDIN.gets.chomp) rescue 0
		rating
	end
end