module Stepable 
    
    def moves 
        # Only for king
        valid_moves = []
        (-1..1).each do |row|
            (-1..1).each do|col|
                if row == 0 && col == 0
                    next
                else
                    valid_moves << [row, col]
                end
            end
        end
        valid_moves
    end

    private 
    def move_diffs 
        
    end 
    
end
