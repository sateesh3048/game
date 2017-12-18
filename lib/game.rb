require_relative "game/version"
require_relative "base_data";
require_relative "validator";
require_relative "tile_positions";

module Game
  class ChessBoard
    include Validator
    include TilePositions
    include BaseData
    
    def initialize(input={})
      @results = []
      @piece = input["piece"]&.downcase&.to_sym
      @initial_position = get_initial_position(input["position"]) 
      @is_valid = true
    end

    # Purpose: It will validate user input by calling validator module.
    # If the user input is valid then it will next possible moves for given chess piece type.
    # returns output with next possible moves.
    def response
      return if invalid_user_input?
      find_next_possible_moves_of_chess_piece
      result
    end

  private

    # Here I am defining rules on how can chess piece can move.
    # queen can move in all sides.
    # rook can move in four sides as defined below.
    # knight will move in L shape.
    def moves
      {
        queen:[up, down, left, right, *diagonal],
        rook: [up, down, left, right],
        knight: knight_diagonals
      }
    end
 
   # Using this method I am finding all possible moves of given chess piece. 
   # One piece can move in multiple directions.So I have configured how it can move in moves method. 
    def find_next_possible_moves_of_chess_piece
      moves[@piece].each do |move|
        move_by_col_and_row(move[:col], move[:row])
      end
    end

    def move_by_col_and_row(col_pos_inc, row_pos_inc, cur_pos=@initial_position)
      return if invalid_position?(col_pos_inc, row_pos_inc)
      next_col =  next_col_position(col_pos_inc, cur_pos)
      next_row = next_row_position(row_pos_inc, cur_pos)
      
      if valid_position?(next_row, next_col)
        next_position = Position.new(next_col, next_row)
        @results << next_position.values.join("") 
        move_by_col_and_row(col_pos_inc, row_pos_inc, next_position) if can_move_piece?
      end
    end

    def next_row_position(row_pos_inc, cur_pos=[])
      current_row_pos = rows.index(cur_pos.row)
      next_row_pos =  current_row_pos + row_pos_inc
      return nil if invalid_tile_position?(next_row_pos)
      rows[next_row_pos]
    end

    def next_col_position(col_pos_inc, cur_pos=[])
      current_col_pos = cols.index(cur_pos.col)
      next_col_pos =  current_col_pos + col_pos_inc 
      return nil if invalid_tile_position?(next_col_pos)
      cols[next_col_pos]
    end

    def result
      @results.join(",")
    end

    def get_initial_position(position="")
      position = position&.split("")
      Position.new(position&.first, position&.last)
    end
  end
end

#  I am receiving input from command prompt 
# converting arguments to key value pairs using hash
unless ARGV.first&.include?("spec/game_spec.rb")
  args = Hash[*ARGV]
  input = args.inject({}){|hsh, (k,v)| hsh[k.sub(/^-/, '')]=v;hsh}
  puts Game::ChessBoard.new(input).response
end