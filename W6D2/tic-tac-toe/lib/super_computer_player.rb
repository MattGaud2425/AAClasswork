require_relative 'tic_tac_toe_node'
require "byebug"

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    game_node = TicTacToeNode.new(game.board, mark)
    game_node.children.each do |child| 
      return child.prev_move_pos if child.winning_node? (mark)
    end

    game_node.children.each do |child|
      return child.prev_move_pos if !child.losing_node?(mark)
    end
    raise "error no losing nodes; tie game"
    
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
