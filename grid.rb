require './cell'
class Grid 
	def initialize(width, height)
		@width = width
		@height = height
		@cells = Array.new(width).map do |row|
			row = Array.new(height).map do |column|
				Cell.new
			end
		end
	end

	def populate
		@cells.each do |row|
			row.each do |cell|
				value = rand(2)
				if value == 1
					cell.alive = true
				else
					cell.alive = false
				end
			end
		end
	end

	def run
		@cells.each_with_index do |row, row_index|
			row.each_with_index do |cell, col_index|
				neighbors = alive_neighbors(col_index, row_index)
				cell.alive = cell.next_state(neighbors)
			end
		end
	end

	def alive_neighbors(y, x)
		count = 0
		(-1..1).each do |x_off|
			(-1..1).each do |y_off|
				unless x_off == 0 && y_off == 0
					x2 = add_index(x_off, x, @height)
					y2 = add_index(y_off, y, @width)
					# puts "#{x}, #{y} => #{x2}, #{y2}"
					cell = @cells[y2][x2]
					count += 1 if cell.alive
				end
			end
		end
		count
	end

	def add_index(offset, current, range)
		new_val = current + offset
		if new_val < 0
			return range - 1
		elsif new_val > range - 1
			return 0
		else
			new_val
		end
	end

	def to_s
		@cells.each_with_index do |row, row_index|
			row.each_with_index do |cell, col_index|
				print "\e[#{col_index + 1};#{row_index + 1}f"
				print 'x' if cell.alive
				print ' ' unless cell.alive
			end
			puts
		end
	end
end