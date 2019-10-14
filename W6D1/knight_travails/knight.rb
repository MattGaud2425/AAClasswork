# Start by creating an instance variable, self.root_node that stores the knight's initial position in an instance of your PolyTreeNode class.

# You will be writing an instance method KnightPathFinder#build_move_tree to build the move tree, beginning with self.root_node. 
# Call this method in initialize; You will traverse the move tree whenever #find_path is called. Don't write this yet though.


# Phase I: #new_move_positions
# Before we start #build_move_tree, you'll want to be able to find new positions you can move to from a given position. Write a class method KnightPathFinder::valid_moves(pos). There are up to eight possible moves.

# You'll also want to avoid repeating positions in the move tree. For instance, we don't want to infinitely explore moving betweeen the same two positions. Add an instance variable, @considered_positions to keep track of 
# the positions you have considered; initialize it to the array containing just the starting pos. Write an instance method #new_move_positions(pos); 
# this should call the ::valid_moves class method, but filter out any positions that are already in @considered_positions. 
# It should then add the remaining new positions to @considered_positions and return these new positions.

# Phase II: #build_move_tree
# Let's return to #build_move_tree. We'll use our #new_move_positions instance method.

# To ensure that your tree represents only the shortest path to a given position, build your tree in a breadth-first manner. 
# Take inspiration from your BFS algorithm: use a queue to process nodes in FIFO order. Start with a root node representing the start_pos and explore moves from one position at a time.

# Next build nodes representing positions one move away, add these to the queue. Then take the next node from the queue... until the queue is empty.

# When you have completed, and tested, #build_move_tree get a code review from your TA.


require_relative "node";

class KnightPathFinder

attr_accessor :root_node, :considered_positions

    def initialize start_pos
        @start_pos = start_pos
        @considered_positions = [position]
        
        build_move_tree
    end

    def self.valid_moves pos 
        valid_moves = []
        # from @position +3 in any direction + 1 in any direction if on the board
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
            x, y = pos
            MOVES.each do |dx, dy|
                new_pos = [x + dx, y + dy]
            if new_pos.all? { |coord| coord.between?(0, 7)}
                valid_moves << new_pos
            end
        end
        valid_moves 
    end

    def new_move_positions
        KnightPathFinder.valid_moves(pos)
        .reject { |new_pos| considered_positions.include? new_pos}
        .each { |new_pos| considered_positions << new_pos }
        
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(start_pos)
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
end

if $PROGRAM_NAME == __FILE__
    kpf = KnightPathFinder.new([0, 0])
    p kpf.find_path([7, 7])
  end