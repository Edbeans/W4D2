module Slideable
    # Don't allow a piece to move into a square already occupied by the same color piece, or to move a sliding piece past a piece that blocks it.
    
    def horizontal_dirs
        # getter
        HORIZONTAL_DIRS
    end
    
    def diagonal_dirs
        #getter
        DIAGONAL_DIRS
    end
    
    def moves
        # create array to collect moves
        all_valid_pos = []
        # iterate over each of the directions in which a slideable piece can move # use the Picce subclass' "#move_dirs" method to get this info
        self.move_dirs.each do |dir| 
            # for each direction, collect all possible moves in that direction 
            #and add then to your moves array
            dx, dy = dir
            # (use the "grow_unblocked_moves_in_dir'helper method)
            all_valid_pos += grow_unblocked_moves_in_dir(dx, dy)
            
        end
        # return the final array of moves (containing all possible moves in all directions)
        all_valid_pos
    end
    
    
    private 
    
    HORIZONTAL_DIRS = [
        [0, -1],  #left 
        [0, 1],  #right
        [-1, 0],  #up
        [1, 0]  #down
    ].freeze

    DIAGONAL_DIRS = [
        [-1, -1], # up+left
        [-1, 1], # up+right
        [1, -1], # down+left
        [1, 1]   # down+right
    ].freeze

    def move_dirs
        #subclass implements this
        raise NotImplementedError
    end
    require 'byebug'
    def grow_unblocked_moves_in_dir(dx, dy)
        # create an array to collect Moves
        valid_moves_for_one_direction = [] 
        # get the piece's current row and current column 
        #rook @ [0,0] can go from [0,0]..[0,7] or [0,0]..[7,0]
        row, col = self.pos  
        # in a loop:
        # continually increment the piece's current row and current column to generate a new position
        new_pos = [row, col]
        while true
            # debugger
            new_pos = [new_pos[0] + dx, new_pos[1] + dy]
            in_bound = new_pos[0].between?(0,7) && new_pos[1].between?(0,7)
            # p new_pos
            other_side_color = :gray
            if self.color == :black 
                other_side_color = :white
            else
                other_side_color = :black
            end
            # stop looping if the new position is invalid (not on the board); the piece can't move in this direction 
            if !in_bound
                break
            else # the new pos is in bound
                end_pos_piece = self.board[new_pos] 
                # if the new position is empty, the piece can move here, so add the new position to the moves array
                if end_pos_piece.is_a?(NullPiece)
                    # p 'Yes'
                    valid_moves_for_one_direction << new_pos
                    # p valid_moves_for_one_direction
                # if the new position is occupied with a piece of the opposite color, the piece can move here (to capture the opposing 
                # but,the piece cannot continue to move past this piece, so stop looping
                elsif end_pos_piece.color == other_side_color 
                    valid_moves_for_one_direction << new_pos
                    break
                # if the new position is occupied with a piece of the same color, stop looping 
                elsif end_pos_piece.color == self.color
                    break 
                end
            end
        end
        # return the final moves array
        valid_moves_for_one_direction  
    end
end
