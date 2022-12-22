require_relative "piece"
require_relative "stepable" 

class King < Piece 
    
    include Stepable 
    def symbol 
        :king
    end

    protected 
    def move_diffs
        moves
    end
end