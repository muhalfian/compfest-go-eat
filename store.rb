class Store
	attr_reader :positions, :symbol, :store_name, :menu

	def initialize(n_map, n_store=3)
		@@n_store =  n_store
		@@n_map = n_map

		@symbol = " A"
		@store_name = Array.new(@@n_store) {|i| {"name" => "Warung " + (i+1).to_s}}
		@menu = Array.new(@@n_store) {|i| Array.new(@@n_store) {|j| {"name" => "Nasi " + (j+1).to_s, "price" => ((j+i+1)*10000/2).to_s}}}
		@positions = Array.new(@@n_store) {{ "x" => (rand @@n_map), "y" => (rand @@n_map) }}
	end
end