require_relative "./piece"

class Board 
    attr_reader :rows

    def initialize  
        row1 = Array.new(2) do |row|
            Array.new(2) {|col| Piece.new(:black, self, [row, col])}
        end
        row2 = Array.new(4) do |row|
            Array.new(4) {|col| Piece.new(:NullPiece, self, [row, col])}
        end
        row3 = Array.new(2) do |row|
            Array.new(2) {|col| Piece.new(:white, self, [row, col])}
        end
        @rows = row1 + row2 + row3
        # @sentinel = NullPiece

    end


    def display_board 
        alph = ("a".."h").to_a
        puts "  " + alph.join(" ")
        idx = 9
        puts(rows.map do |row|
            (idx).to_s + " " + row.join(' ')
            idx -= 1
        end.join("\n"))
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, val)
        
        
        row, col = pos
        @rows[row][col] = val
    end

    def valid_pos?(val)
    end

    def add_piece(piece, pos)
    end

    def checkmate?(color)
    end

    def in_check?(color)
    end

    def find_king(color)
    end

    def pieces
    end

    def dup 

    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        raise "no piece at start_pos" if self[start_pos].color == :NullPiece
        raise "Piece already placed there!" unless self[end_pos].color == :NullPiece
        
        self[end_pos] = piece
        piece.pos = end_pos
        self[star_pos] = NullPiece.new()
        
    end
end

board = Board.new
p board.display_board
pos1 = [7, 1]
pos2 = [4, 0]
p board[pos2].color
board.move_piece!(pos1, pos2)
p board[pos2].color
p board[pos1].color