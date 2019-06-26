class Me
	attr_reader :positions, :symbol

	def initialize(n_map, *coordinate)
		@@n_map = n_map

		@symbol = " x"
		if coordinate.length > 0
			@positions = Array.new(1) {{ "x" => (coordinate[0].to_i), "y" => (coordinate[1].to_i) }}
		else
			@positions = Array.new(1) {{ "x" => (rand n_map), "y" => (rand n_map) }}
		end
	end
end