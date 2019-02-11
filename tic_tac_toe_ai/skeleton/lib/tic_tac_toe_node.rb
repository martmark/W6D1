require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_accessor :board, :next_mover_mark, :prev_move_pos
  
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end


  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    (0..2).each do |row|
      (0..2).each do |col|
        pos = [row, col]
        if @board.empty?(pos)
          new_board = board.dup
          next_mover_mark = self.next_mover_mark == :x ? :o : :x
          new_board[pos] = self.next_mover_mark
          
          children << TicTacToeNode.new(new_board, next_mover_mark, pos)
        end
      end
    end

    children
  end

  def losing_node?(evaluator)
    if board.over? 
      return board.won? && board.winner != evaluator
    end
    
    if self.next_mover_mark == evaluator
      self.children.all? { |child| child.losing_node?(evaluator) }
    else
      self.children.any? { |child| child.losing_node?(evaluator) }
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return  board.winner == evaluator
    elsif self.next_mover_mark == evaluator 
        self.children.any? {|child| child.winning_node?(evaluator)}
    else
        self.children.all? {|child| child.winning_node?(evaluator)}
    end     
  end


end
