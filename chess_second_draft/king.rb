require_relative 'board'
require_relative "piece"
require_relative "stepable" 
require 'colorize' 

class King < Piece 
    
    include Stepable 
    def symbol 
        '♔'.colorize(color)# white king symbol on website 
    end

    protected 
    def move_diffs
        # return an array of diffs representing where a king can step to
        [
        [0, -1], # left
        [0, 1], # right 
        [-1, 0], # up 
        [1, 0], # down 
        [-1, -1], # up + left 
        [-1, 1], # up + right 
        [1, -1], # down + left 
        [1, 1] # down + right 
        ]
    end
end