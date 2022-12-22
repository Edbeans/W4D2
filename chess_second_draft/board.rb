require_relative "piece"
require_relative "rook"
require_relative "bishop"
require_relative "queen"
require_relative "knight"
require_relative "king"
require_relative "pawn"
require_relative "nullpiece"
require_relative "cursor"
require_relative "player"
require_relative "display"

class Board
    attr_accessor :rows
    def initialize
        # Each position in the board holds either a moving Piece or a NullPiece. (NullPiece will inherit from Piece.)
        @null_piece = NullPiece.instance
        @rows = Array.new(8) { Array.new(8, null_piece) } # Array
        # create an empty Piece class as a placeholder for now. Write code for #initialize so we can set up the board with instances of Piece in locations where a Queen/Rook/Knight/ etc. will start and nil where the NullPiece will start.
        (0..7).each do |i|
            (0..7).each do |j|
                case i
                when  0  #black side
                    case j
                    when 0 
                        @rows[i][j] = Rook.new(:black, self, [i, j])
                    when 7
                        @rows[i][j] = Rook.new(:black, self, [i, j])
                    when 1
                        @rows[i][j] = Knight.new(:black, self, [i, j])
                    when 6
                        @rows[i][j] = Knight.new(:black, self, [i, j])
                    when 2
                        @rows[i][j] = Bishop.new(:black, self, [i, j])
                    when 5
                        @rows[i][j] = Bishop.new(:black, self, [i, j])
                    when 3 
                        @rows[i][j] = Queen.new(:black, self, [i, j])
                    when 4 
                        @rows[i][j] = King.new(:black, self, [i, j])
                    end
                when 7  #white side
                    case j
                    when 0
                        @rows[i][j] = Rook.new(:white, self, [i, j])
                    when 7
                        @rows[i][j] = Rook.new(:white, self, [i, j])
                    when 1
                        @rows[i][j] = Knight.new(:white, self, [i, j])
                    when 6
                        @rows[i][j] = Knight.new(:white, self, [i, j])
                    when 2 
                        @rows[i][j] = Bishop.new(:white, self, [i, j]) 
                    when 5 
                        @rows[i][j] = Bishop.new(:white, self, [i, j]) 
                    when 3 
                        @rows[i][j] = Queen.new(:white, self, [i, j])
                    when 4 
                        @rows[i][j] = King.new(:white, self, [i, j])
                    end
                when 1
                    @rows[i][j] =  Pawn.new(:black, self, [i, j]) 
                when 6
                    @rows[i][j] =  Pawn.new(:white, self, [i, j]) 
                end
            end
        end
    end

    def [](pos)
        rows[pos[0]][pos[1]] 
    end
    
    def[]=(pos, val)
        row, col = pos
        rows[row][col] = val
    end
    require 'byebug'
    def move_piece(start_pos, end_pos)   
        # there is no piece at start_pos
        if !start_pos[0].between?(0, 7) || !start_pos[1].between?(0, 7) 
            raise "Invalid starting position!"
        elsif self[start_pos] ==  @null_piece
            raise "Empty starting position!"
        # the piece cannot move to end_pos
        elsif !end_pos[0].between?(0, 7) || !end_pos[1].between?(0, 7) || self[end_pos].color == self[start_pos].color
            raise "Invalid ending position!"
        end
        self[start_pos].pos = end_pos
        self[end_pos] = self[start_pos]
        self[start_pos] = self.null_piece
    end

    def valid_pos?(pos) 
        pos[0].between?(0, 7) && pos[1].between?(0, 7)
    end

    def add_piece(piece, pos)
    end

    def checkmate?(color)
        # If the player is in check
        color == :white ? other_side_color = :black : other_side_color = :white
        if in_check?(color) 
            # if none of the player's pieces have any #valid_moves (to be implemented in a moment), then the player is in checkmate.
            rows.each {|row| row.each {|ele| return true if ele.valid_moves != nil}}
            false
        end
    end

    def in_check?(color)
        # returns whether a player is in check.
        # (1) finding the position of the King on the board then 
        color == :white ? other_side_color = :black : other_side_color = :white  
        king_pos = find_king(color)
        # (2) seeing if any of the opposing pieces can move to that position.
        rows.each.with_index do |row, i| 
            row.each.with_index do |ele, j|
                if ele.valid_moves != nil && ele.valid_moves.include?(king_pos) && ele.color == other_side_color
                    return true
                end
            end
        end
        false
    end

# f2[1, 2], f3 [2, 3]
# e7[6, 4] e5 [4, 4]
# g2[1, 1], g4 [3, 1]
# d8[7, 4], h4 [3, 0]
    def find_king(color) 
        # king_pos = rows.flatten 
        # iterate, and if ele is_a?(King) && ele.color == color return King pos 
        rows.each.with_index do |row, i|
            row.each.with_index do |ele, j|
                if ele.is_a?(King) && ele.color == color
                    return [i, j]
                end
            end
        end
    end

    def pieces
    end

    def dup
    end

    private
    attr_accessor :null_piece 

    def move_piece!(color, start_pos, ending_pos)

    end
end
