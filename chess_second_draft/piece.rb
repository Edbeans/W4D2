# require_relative 'nullpiece'
class Piece
    attr_reader :color, :board
    attr_accessor :pos
    def initialize(color, board, pos)
        @color = color #symbol
        @board = board #Board
        @pos = pos  #Array
    end

    def to_s
        symbol
    end

    def empty?
    end
    
    def valid_moves
        self.moves
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