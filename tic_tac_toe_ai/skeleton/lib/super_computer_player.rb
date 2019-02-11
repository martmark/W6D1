require_relative 'tic_tac_toe_node'
require 'byebug'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
  
    found = node.children.find { |child| child.winning_node?(mark) }
    return found.prev_move_pos if found
    # node.children.each do |child|
    #   if child.winning_node?(mark)
    #     return child.prev_move_pos
    #   end
    # end

    # debugger
    node.children.each do |child|
      if !child.losing_node?(mark)
        return child.prev_move_pos
      end
    end

    raise "No non-losing nodes found"
  end


end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
