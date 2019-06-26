class Maps
	# Maps
	def initialize(name, me, driver, store, n_map)
		
		# init size maps
		@@n_map = n_map
		@@name = name
		@@me = me
		@@driver = driver
		@@store = store
	end

	def generate_maps()
		# generate maps
		@@maps = Array.new(@@n_map) {[' .'] * @@n_map}
		self.plot(@@me)
		self.plot(@@driver)
		self.plot(@@store)
		self.visualize_maps()	
		puts ""
		print("back? (Y/n) ")
		ans = STDIN.gets.chomp
		if ans == 'n'
			exit(true)
		end
	end

	def generate_maps_order(driver_id, store_id)
		# generate maps
		@@maps = Array.new(@@n_map) {[' .'] * @@n_map}
		self.plot_loc(@@store.positions[store_id], @@store.symbol)
		self.plot(@@me)
		self.plot_loc(@@driver.positions[driver_id], @@driver.symbol)
		
		# self.visualize_maps()	
		# puts ""
	end

	def print_route(data_1, data_2)
		a = data_1["x"].to_i+1
		b = data_2["x"].to_i
		if b<a
			a = data_2["x"].to_i+1
			b =  data_1["x"].to_i
		end

		for i in a..b
			if(self.not_crash(i,data_2["y"]))
				@@maps[i][data_2["y"]] = " |"
			end
		end

		a = data_1["y"].to_i+1
		b = data_2["y"].to_i
		if b<a
			a = data_2["y"].to_i+1
			b =  data_1["y"].to_i
		end

		for i in a..b
			if(self.not_crash(data_1["x"],i))
				@@maps[data_1["x"]][i] = "--"
			end
		end
	end

	def generate_route(driver_id, store_id)
		self.generate_maps_order(driver_id, store_id)

		driver_loc = @@driver.positions[driver_id]
		store_loc = @@store.positions[store_id]
		me_loc = @@me.positions[0]

		system "clear" or system "cls"
		puts ""
		puts "Driver on the way to store"
		puts ""

		# driver to store
		self.print_route(store_loc,driver_loc)

		self.visualize_maps()
		sleep(5)

		system "clear" or system "cls"
		puts ""
		puts "driver arrived at the store !"
		puts ""
		@@driver.positions[driver_id] = store_loc
		driver_loc = store_loc
		self.generate_maps_order(driver_id, store_id)
		self.visualize_maps()
		sleep(5)

		system "clear" or system "cls"
		puts ""
		puts "driver has bought the item(s)"
		puts ""

		# driver to store
		self.print_route(driver_loc, me_loc)

		self.visualize_maps()
		sleep(5)

		system "clear" or system "cls"
		puts ""
		puts "driver arrived at your place"
		puts ""
		@@driver.positions[driver_id] = me_loc
		self.generate_maps_order(driver_id, store_id)
		self.visualize_maps()
		sleep(3)
	end

	def not_crash(x,y)
		if @@maps[x][y] == " ."
			return true
		else 
			return false
		end
	end

	def find_nearest_driver(id)
		store_loc = @@store.positions[id]
		distance_arr = []
		@@driver.positions.each_with_index do |loc, i|
			dist = self.get_distance(loc, store_loc)
			distance_arr.push({"driver"=>i, "distance"=>dist})
		end
		distance_arr.sort_by!{ |data| data["distance"] }
		distance_arr[0]["driver"]
	end

	def start_order(store_id)
		system "clear" or system "cls"
		puts ""
		puts "looking for drivers . . "
		puts ""
		sleep(3)
		driver_id = self.find_nearest_driver(store_id)
		
		self.generate_route(driver_id, store_id)
		rating = @@driver.give_rating(driver_id)
		if rating == 0
			puts "*** value should be integer and must not be 0 ***"
			@@driver.give_rating
		end
		@@driver.ratings[driver_id].push(rating)
		puts ""
		puts "Thank you "
		puts ""
		print("Back to Home ? (Y/n) ")
		ans = STDIN.gets.chomp
	end

	def visualize_maps()
		# print maps
		@@maps.each do |data|
			data.each do |dots|
				print dots
			end
			puts ""
		end
		puts ""
		# print legends
		puts "#{@@me.symbol} = #{@@name}'s location"
		puts "#{@@driver.symbol} = Go-Eat drivers"
		puts "#{@@store.symbol} = Stores"
	end

	def get_distance(one, two)
		distance = ((one['x'].to_i-two['x'].to_i).abs + (one['y'].to_i-two['y'].to_i).abs)
	end

	def plot(obj)
		obj.positions.map {|data| @@maps[data['x']][data['y']] = obj.symbol}
	end

	def plot_loc(loc, sym)
		@@maps[loc['x']][loc['y']] = sym
	end

	def me
		super
	end

	def driver
		super
	end

	def store
		super
	end
end