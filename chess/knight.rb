require_relative "piece" 
require_relative "stepable" 
require_relative 'board'
class Knight < Piece
    include Stepable 
    
    def symbol
        :knight
    end
    
    protected 
    def move_diffs 
        valid_moves = [[1,2], [-1,2], [1,-2],[-1,-2], [2,1], [-2,1], [2, -1], [-2,-1]] 
        
    end

end

