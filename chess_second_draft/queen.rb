require_relative "piece"
require_relative "slideable"

class Queen < Piece 
    
    include Slideable

    def symbol 
        '♕'.colorize(color) #white queen symbol 
    end
  
    private

    def move_dirs
        # return the directions in which a queen can move
        # a queen can move horizontally 
        # all_dirs = []
        # (0..3).each do |i|
        #     all_dirs <<  HORIZONTAL_DIRS[i]
        #     all_dirs <<  DIAGONAL_DIRS[i]
        # end       
        # all_dirs     
        HORIZONTAL_DIRS + DIAGONAL_DIRS
    end
end

