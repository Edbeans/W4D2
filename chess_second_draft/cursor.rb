require "io/console"

KEYMAP = {
  " " => :space,
  "h" => :left,
  "j" => :down,
  "k" => :up,
  "l" => :right,
  "w" => :up,
  "a" => :left,
  "s" => :down,
  "d" => :right,
  "\t" => :tab,
  "\r" => :return,
  "\n" => :newline,
  "\e" => :escape,
  "\e[A" => :up,
  "\e[B" => :down,
  "\e[C" => :right,
  "\e[D" => :left,
  "\177" => :backspace,
  "\004" => :delete,
  "\u0003" => :ctrl_c,
}

MOVES = {
  left: [0, -1],
  right: [0, 1],
  up: [-1, 0],
  down: [1, 0]
}

class Cursor

  attr_reader :board
  attr_accessor :cursor_pos, :selected

  def initialize(cursor_pos, board)
    @cursor_pos = cursor_pos
    @board = board
    @selected = false
    # A nice but optional addition to your cursor class is a boolean instance variable selected that will allow you to display the cursor in a different color when it has selected a piece. To implement this you will need to #toggle_selected everytime :return or :space is hit.
  end

  def toggle_selected
    @selected = !@selected
  end

  def get_input
    key = KEYMAP[read_char] # key becomes KEYMAP of 'a' which is :left 
    handle_key(key) #handle_key(:left) 
  end

  private

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a numeric keycode. chr returns a string of the character represented by the keycode. (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads at most maxlen bytes from a data stream; it's nonblocking, meaning the method executes asynchronously; it raises an error if no data is available, hence the need for rescue
      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key) # handle_key(:left) 
    #handle_key(key) will a) return the @cursor_pos (in case of :return or :space), 
    #b) call #update_pos with the appropriate movement difference from MOVES and return nil (in case of :left, :right, :up, and :down), or 
    #c) exit from the terminal process (in case of :ctrl_c). 
    #Later we will use our Player and Game classes to handle the movement of pieces.
    case key
    when :return
        toggle_selected
        @cursor_pos
    when :space
        @cursor_pos
    when :left
        update_pos(MOVES[key]) #[0, -1]
        nil
    when :right
        update_pos(MOVES[key]) #[0, 1]
        nil
    when :up
        update_pos(MOVES[key]) #[-1, 0]
        nil 
    when :down
        update_pos(MOVES[key]) #[1, 0] 
        nil
    when :ctrl_c
        # To exit a terminal process, use the Process.exit method. Pass it the status code 0 as an argument.
        Process.exit(0)
    end 
  end

  def update_pos(diff) #[0, -1]
    #Fill in the #update_pos(diff) method. It should use the diff to reassign @cursor_pos to a new position. You may wish to write a Board#valid_pos? method to ensure you update @cursor_pos only when the new position is on the board.
    new_pos = [cursor_pos[0] + diff[0], cursor_pos[1] + diff[1]]
    if board.valid_pos?(new_pos) 
        self.cursor_pos = new_pos
    end
  end
end