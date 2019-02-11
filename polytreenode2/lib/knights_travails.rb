require_relative "00_tree_node.rb"

class KnightPathFinder
    attr_reader :considered_positions, :pos 
    attr_accessor :root_node

    MOVES = [
    [-2, -1],
    [-2,  1],
    [-1, -2],
    [-1,  2],
    [ 1, -2],
    [ 1,  2],
    [ 2, -1],
    [ 2,  1]]

  def self.valid_moves(pos)
    valid_moves = []

    cur_x, cur_y = pos
    MOVES.each do |(dx, dy)|
      new_pos = [cur_x + dx, cur_y + dy]

      if new_pos.all? { |coord| coord.between?(0, 7) }
        valid_moves << new_pos
      end
    end

    valid_moves
  end


    def initialize(pos)
        @pos = pos
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]

    end

    def new_move_positions(pos)
        valids = KnightPathFinder.valid_moves(pos)
        unconsidered = valids.reject { |move| self.considered_positions.include?(move) }
        @considered_positions += unconsidered
        unconsidered
    end

    def build_move_tree 
        self.root_node = PolyTreeNode.new(pos)
        nodes = [@root_node]

        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end 

    def find_path(end_pos)
        self.build_move_tree
        result = self.root_node.bfs(end_pos)
        if result != nil
            self.trace_path_back(result)
        end 

    end

    def trace_path_back(node)
        path = []
        current = node
        until current.nil?
            path << current.value
            current = current.parent
        end
        path.reverse
    end
  
end