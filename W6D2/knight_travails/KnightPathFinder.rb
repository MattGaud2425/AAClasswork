# Phase III: #find_path
# Now that we have created our internal data structure (the move tree stored in self.root_node), we can traverse it to find the shortest path to any position on the board from our original @start_pos.

# Create an instance method #find_path(end_pos) to search for end_pos in the move tree. You can use either dfs or bfs search methods from the PolyTreeNode exercises; it doesn't matter. This should return the tree node instance containing end_pos.

# This gives us a node, but not a path. Lastly, add a method #trace_path_back to KnightPathFinder. This should trace back from the node to the root using PolyTreeNode#parent. As it goes up-and-up toward the root, it should add each value to an array. 
# #trace_path_back should return the values in order from the start position to the end position.

# Use #trace_path_back to finish up #find_path.

# Here are some example paths that you can use for testing purposes (yours might not be exactly the same, but should be the same number of steps);


require_relative "./node";

class KnightPathFinder

attr_accessor :root_node, :considered_positions

MOVES = [
    [-2, 1],
    [-2, -1],
    [1, -2],
    [1, 2],
    [2, 1],
    [-1, -2],
    [-1, 2],
    [2, -1]
]

    def initialize start_pos
        @start_pos = start_pos
        @considered_positions = [start_pos]
        
        build_move_tree
    end

    def self.valid_moves pos 
        valid_moves = []
        # from @position +3 in any direction + 1 in any direction if on the board
  
            x, y = pos
            MOVES.each do |dx, dy|
                new_pos = [x + dx, y + dy]
            if new_pos.all? { |coord| coord.between?(0, 7)}
                valid_moves << new_pos
            end
        end
        valid_moves 
    end

    def new_move_positions pos
        KnightPathFinder.valid_moves(pos)
        .reject { |new_pos| considered_positions.include? new_pos}
        .each { |new_pos| considered_positions << new_pos }
        
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@start_pos)
        nodes = [root_node]
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
        end_node = root_node.dfs(end_pos)

        trace_path_back(end_node)
        .reverse
        .map(&:value)

    end

    def trace_path_back(end_node)
        vals = [end_node]
        until vals.include? root_node
            vals << end_node.parent 
            end_node = end_node.parent

        end
        vals     
    end
end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([1,1])
    p kpf.find_path([7,7])
end

