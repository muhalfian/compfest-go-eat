class Order
	def initialize(name, me, driver, store, n_map, map)
		
		# init size maps
		@@n_map = n_map
		@@name = name
		@@me = me
		@@driver = driver
		@@store = store
		@orders = []
		@@unit_cost = 300
		@@store_choise = false
		@@map = map
		# @@db = db
	end

	def check_not_valid(i)
		if (i<0 || i>3)
			system "clear" or system "cls"
			self.warning_input()
			self.start()
		else 
			return i
		end
	end

	def warning_input()
		puts ""
		puts "*** WARNING : Input must be integer (1-3) ***"
		puts ""
	end

	def start()
		self.choose_store()
		if(@@store_choise == -1)
			@@store_choise = false
			return 0
		end
		self.choose_menu()
		self.choose_n()
		
		@orders.push({"store" => @@store_choise, "menu" => @@menu_choise, "n" => @@n_menu})

		print "Do you want to Order again ? (y/N)"
		ans = STDIN.gets.chomp
		self.turn_back(ans, "y")
		self.show_order()
		# @@db.save(self)
	end

	def show_order()
		system "clear" or system "cls"

		puts ""
		print " " * 30
		puts "DETAIL ORDER"
		puts ""
		print "|"
		print "=" * 65
		puts "|"
		puts "     Menu \t Amount \t Price \t\t Total"
		print "|"
		print "=" * 65
		puts "|"

		total = 0
		@orders.each_with_index do |data, i|
			menu_name = @@store.menu[data['store']][data['menu']]['name']
			menu_price = @@store.menu[data['store']][data['menu']]['price'].to_i
			total_temp = data['n'] * menu_price
			total += total_temp
			puts "  #{(i+1)}. #{menu_name} \t #{data['n']} \t\t IDR #{menu_price} \t IDR #{total_temp}"
		end
		print "|"
		print "=" * 65
		puts "|"		
		puts "\t\t\t\t Sub Total \t IDR #{total}"

		@@unit_distance = @@map.get_distance(@@me.positions[0],@@store.positions[@@store_choise])*2
		@@delivery_fee = @@unit_cost * @@unit_distance
		puts "\t\t\t\t Delivery Fee \t IDR #{@@delivery_fee}"		

		print "|"
		print "=" * 65
		puts "|"
	
		@@all_total = @@delivery_fee + total
		puts "\t\t\t\t Total \t\t IDR #{@@all_total}"

		print "CONFIRM (Y/n) "
		ans = STDIN.gets.chomp
		self.turn_back(ans, "n")
		@@map.start_order(@@store_choise)
		return 0
	end

	def choose_store()
		if(@@store_choise==false)
			puts "Popular stores : "
			puts ""
			n_store = 0
			@@store.store_name.each_with_index do |data, i|
				puts "#{(i+1)}. #{data['name']}"
				n_store+=1
			end
			puts "0. back"
			puts ""
			print "Enter your choise : "
			@@store_choise = Integer(STDIN.gets.chomp)-1 rescue -1
			if (@@store_choise >= n_store || @@store_choise <= 0)
				@@store_choise = -1
			end
		end
	end

	def choose_menu()
		puts ""
		puts "#{@@store.store_name[@@store_choise]['name']}\'s Menu : "
		puts ""
		@@store.menu[@@store_choise].each_with_index do |data, i|
			puts "#{(i+1)}. #{data['name']} \n   IDR. #{data['price']}"
		end
		puts "0. back"
		puts ""
		print "Enter your choise : "
		@@menu_choise = Integer(STDIN.gets.chomp)-1 rescue -1
		if @@menu_choise == -1
			@@store_choise = false
		end
		self.turn_back(@@menu_choise, -1)
	end

	def choose_n()
		print "How much #{@@store.menu[@@store_choise][@@menu_choise]['name']} do you want : "
		@@n_menu = Integer(STDIN.gets.chomp) rescue 0
		if @@n_menu == 0
			puts "*** value should be integer and must not be 0 ***"
			self.choose_n()
		end
	end

	def turn_back(item, value)
		if(item==value)
			system "clear" or system "cls"
			self.start()
		end
	end
end
