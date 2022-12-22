require_relative "piece" 
require_relative "stepable" 
require 'colorize' 

class Knight < Piece

    include Stepable 
    
    def symbol
        '♘'.colorize(color) #white knight symbol 
    end
    
    protected 
    def move_diffs 
        valid_moves = [
            [1, 2], 
            [-1, 2], 
            [1, -2],
            [-1, -2], 
            [2, 1], 
            [-2, 1], 
            [2, -1], 
            [-2, -1]
        ] 
    end

end
