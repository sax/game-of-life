class State
  def initialize(initial_state)
    @initial_state = @next_state = initial_state
  end

  def next
    @next_state = @initial_state.map.with_index do |row, row_index|
      row.map.with_index do |column, column_index|
        count = live_neighbors_count(row_index, column_index)
        next 1 if column == 0 && count == 3
        next column if count == 2 || count == 3
        0
      end
    end
  end

  def live_neighbors_count(x, y)
    neighbors(x, y).sum
  end

  def neighbors(x, y)
    neighbors = (x-1..x+1).map do |row|
      (y-1..y+1).map do |column|
        next if row == x && column == y
        next unless @initial_state[row]
        @initial_state[row][column]
      end
    end.flatten.compact
  end
end
