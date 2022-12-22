
module Stepable 
    DIRECTIONS = [
        [0, -1], # left
        [0, 1], # right 
        [-1, 0], # up 
        [1, 0], # down 
        [-1, -1], # up + left 
        [-1, 1], # up + right 
        [1, 1], # down + right 
        [1, -1] # down + left 
    ]

    def moves 
       # create array to collect moves
       valid_moves = []
        # iterate through each of the piece's possible move diffs 
        self.move_diffs.each do |pos|
            #each move diff,increment the piece's position to generate a new position 
            # add the new position to the moves array if it is:
            # on the board and empty
            new_pos = [self.pos[0] + pos[0], self.pos[1] + pos[1]] 
            in_bound = new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
            end_pos_piece = self.board[new_pos]
            
            # OR on the board and contains a piece of the opposite color # return the final array of moves
            # elsif new_pos[0].between?(0,7) && new_pos[1].between?(0,7) && self.
            if in_bound && (end_pos_piece.is_a?(NullPiece) || end_pos_piece.color != self.color)
                valid_moves << new_pos
            end
        end
        valid_moves
    end

    private 

    def move_diffs 
        #subclass implements this 
        raise NotImplementedError # optional 
    end 
    
end
