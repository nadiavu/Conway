class Cell
	attr_accessor :alive

	def initialize(alive = false)
		@alive = alive
	end

	def next_state(neighbors)
		if alive
			case neighbors
			when (0..1) # underpopulation
				false
			when (2..3) # lives
				true
			when (4..8) # overcrowded
				false
			end
		else
			if neighbors == 3
				true
			else
				false
			end
		end 
	end
end
