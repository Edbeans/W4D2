require_relative 'board'
require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :cursor, :board
    def initialize(board)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end
    
    def method(x, y)
        color = :gray
        if cursor.cursor_pos[0] == x && cursor.cursor_pos[1] == y && cursor.selected
            color = :green
        end
        {background: color}
    end
    require 'byebug'
    def render 
        # Render the square at the @cursor_pos display in a different color. Test that you can move your cursor around the board by creating and calling a method that loops through Display#render and Cursor#get_input (much as Player#make_move will function later!).
        system('clear')
        render_grid.each {|row| puts row.join('|')}
        cursor.get_input
        render
    end

    def render_grid 
        board.rows.map.with_index {|row, i| render_row(row, i) }
    end

    def render_row(row, i) 
        row.map.with_index {|col, j| col.to_s.colorize(method(i, j))}
    end
end
