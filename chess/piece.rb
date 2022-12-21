class Piece
    attr_reader :color, :pos
    def initialize(color, board, pos)
        @color = color #symbol
        @board = board #Board
        @pos = pos  #Array
    end

    def to_s

    end

    def empty?
    end

    def valid_moves
    end
    
    def pos=(val)
    end
    
    def symbol
    end
    
    def inspect
        self.class
    end

    private 

    def move_into_check?(end_pos) 
    
    end
end