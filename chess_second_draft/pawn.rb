require_relative "piece" 

class Pawn < Piece
    
    def symbol
        '♙'.colorize(color) 
    end

    def moves
        valid_moves = []
        forward_steps.each do |pos|
            in_bound = pos[0].between?(0,7) && pos[1].between?(0,7)
            if !in_bound
                next
            else
                end_pos_piece = self.board[pos]
                if end_pos_piece.is_a?(NullPiece) || end_pos_piece.color != self.color 
                    valid_moves << pos 
                end
            end
        end 
        valid_moves + side_attacks 
    end

    private 

    def at_start_row?
        if self.color == :black
            return self.pos[0] == 1
        else # self.color == :white 
            return self.pos[0] == 6
        end
    end

    def forward_dir
        if self.color == :black
            return [1, 0]
        else # self.color == :white 
            return [-1, 0]
        end
    end

    def forward_steps #return an pos array containing the valid (1 or 2) step
        valid_steps = []
        dir = forward_dir
        other_side_color = :gray
        if self.color == :black 
            other_side_color = :white
        else
            other_side_color = :black
        end

        one_step = [self.pos[0] + dir[0], self.pos[1] + dir[1]]
        if self.board[one_step].color == other_side_color
            return []  
        elsif at_start_row?
            two_steps = [one_step[0] + dir[0], one_step[1] + dir[1]]
            valid_steps << one_step
            valid_steps << two_steps 
        else
            valid_steps << one_step
        end
        valid_steps
    end

    def side_attacks #return an array containing the valid attack pos
        valid_attacks = []
        if self.color == :black
            left_attack = [self.pos[0] + 1, self.pos[1] - 1] #down + left 
            left_in_bound = left_attack[0].between?(0, 7) && left_attack[1].between?(0, 7) 
            right_attack = [self.pos[0] + 1, self.pos[1] + 1]
            right_in_bound = right_attack[0].between?(0, 7) && right_attack[1].between?(0, 7) 
            valid_attacks << left_attack if left_in_bound && self.board[left_attack].color == :white
            valid_attacks << right_attack if right_in_bound && self.board[right_attack].color == :white
        else # self.color == :white 
            left_attack = [self.pos[0] - 1, self.pos[1] - 1] #up + left 
            left_in_bound = left_attack[0].between?(0, 7) && left_attack[1].between?(0, 7) 
            right_attack = [self.pos[0] - 1, self.pos[1] + 1]
            right_in_bound = right_attack[0].between?(0, 7) && right_attack[1].between?(0, 7) 
            valid_attacks << left_attack if left_in_bound && self.board[left_attack].color == :black
            valid_attacks << right_attack if right_in_bound && self.board[right_attack].color == :black
        end
        valid_attacks
    end
    
end