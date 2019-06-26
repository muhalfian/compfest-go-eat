require "json"
require "date"

class Database

	def initialize(name, me, driver, store, n_map, map)	
		# init size maps
		@@n_map = n_map
		@@name = name
		@@me = me
		@@driver = driver
		@@store = store
		@@map = map
	end

	def save(order)
		datetime = Time.now.strftime("%d/%m/%Y %H:%M")
		data = order.orders[-1]
		driver_id = data['driver']
		store_id = data['store']
			
		data_json = {
			"name" => @@name,
			"date" => datetime,
			"driver" => {
				"name" => @@driver.name[driver_id],
				"id" => driver_id
			},
			"store" => {
				"name" => @@store.name[store_id],
				"id" => store_id
			},
			"item" => {
				"name" => @@store.name[store_id],
				"id" => store_id
			}

		}	
		
	end
end