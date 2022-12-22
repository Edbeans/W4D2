# require_relative "piece"
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
                        @rows[i][j] = Rook.new(:Black, self, [i, j])
                    when 7
                        @rows[i][j] = Rook.new(:Black, self, [i, j])
                    when 1
                        @rows[i][j] = Knight.new(:Black, self, [i, j])
                    when 6
                        @rows[i][j] = Knight.new(:Black, self, [i, j])
                    when 2
                        @rows[i][j] = Bishop.new(:Black, self, [i, j])
                    when 5
                        @rows[i][j] = Bishop.new(:Black, self, [i, j])
                    when 3 
                        @rows[i][j] = Queen.new(:Black, self, [i, j])
                    when 4 
                        @rows[i][j] = King.new(:Black, self, [i, j])
                    end
                when 7  #white side
                    case j
                    when 0
                        @rows[i][j] = Rook.new(:White, self, [i, j])
                    when 7
                        @rows[i][j] = Rook.new(:White, self, [i, j])
                    when 1
                        @rows[i][j] = Knight.new(:White, self, [i, j])
                    when 6
                        @rows[i][j] = Knight.new(:White, self, [i, j])
                    when 2 
                        @rows[i][j] = Bishop.new(:White, self, [i, j]) 
                    when 5 
                        @rows[i][j] = Bishop.new(:White, self, [i, j]) 
                    when 3 
                        @rows[i][j] = Queen.new(:White, self, [i, j])
                    when 4 
                        @rows[i][j] = King.new(:White, self, [i, j])
                    end
                when 1
                    @rows[i][j] =  Pawn.new(:Black, self, [i, j]) 
                when 6
                    @rows[i][j] =  Pawn.new(:White, self, [i, j]) 
                end
            end
        end
    end

    def [](pos)
        row, col = pos
        rows[row][col] 
    end
    
    def[]=(pos, val)
        row, col = pos
        rows[row][col] = val
    end

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
        self[end_pos] = self[start_pos]
        self[start_pos] = self.null_piece
    end

    def valid_pos?(pos) 
    end

    def add_piece(piece, pos)
    end

    def checkmate?(color)
    end

    def in_check?(color)
    end

    def find_king(color)
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
