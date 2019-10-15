require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos

  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

# A #losing_node? is described in the following cases:

# Base case: the board is over AND
# If winner is the opponent, this is a losing node.
# If winner is nil or us, this is not a losing node.

# Recursive case:
#   It is the player's turn, and all the children nodes are losers for the player (anywhere they move they still lose), OR
#   It is the opponent's turn, and one of the children nodes is a losing node for the player (assumes your opponent plays perfectly; 
#   they'll force you to lose if they can).

  def losing_node?(evaluator)
    #return false unless evaluator.winner == :x && @board.over?
      return @board.won? && @board.winner != evaluator if @board.over?
      if self.next_mover_mark == evaluator 
        self.children.all? { |child| child.losing_node?(evaluator) }
      else
        self.children.any? { |child| child.losing_node?(evaluator) }
      end
    # return false unless evaluator.winner || evaluator.nil?
  end

  def winning_node?(evaluator)
    return @board.winner == evaluator if @board.over?
    if self.next_mover_mark == evaluator 
      self.children.any? { |child| child.winning_node?(evaluator) }

    else
      self.children.all? { |child| child.winning_node?(evaluator) }

    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []
    (0..2).each do |row_index|
      (0..2).each do |col_index|
        pos = [row_index, col_index]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = self.next_mover_mark
          next_mover_mark = (self.next_mover_mark == :x ? :o : :x)
          children << TicTacToeNode.new(new_board, next_mover_mark, pos)
        end
      end
    end
    children

  end


end
