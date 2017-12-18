# purpose: Validator module is created to validate user input
module Validator
  CHESS_PIECE_TYPES = [:queen, :rook, :knight]
  MIN_POS = 0
  MAX_POS = 8
  private 
    # Validating whether user entered chess piece type is supported or not.
    # Validating whether user entered position is valid boundary or not.
    # returns whether user input is valid or not by send true/false value.
    def validate_user_input
      validate_chess_piece_type
      validate_current_position_boundaries
      @is_valid
    end

    def invalid_user_input?
      validate_user_input
      !@is_valid
    end

    # Method for validating user entered chess piece type
    def validate_chess_piece_type
      unless CHESS_PIECE_TYPES.include?(@piece)
        puts "\nPlease enter valid chess piece type. Eg: -piece queen"
        puts "Please type one of these chess piece types"
        puts CHESS_PIECE_TYPES.join(' ')
        @is_valid = false
      end
    end

    # Method for checking user entered current position is in chess board tiles range.
    def validate_current_position_boundaries
      if (@initial_position.nil? || row_pos_invalid? || col_pos_invalid?) 
        puts "\nPlease enter valid chess piece position. Eg: -position a1"
        puts "Please type one of these positions"
        puts valid_boundaries
        @is_valid = false
      end
    end
    
    #Checking user entered row position is valid or not.
    def row_pos_invalid?(row_pos=@initial_position.row)
      !rows.include?(row_pos.to_s)
    end

    #Checking user entered col position is valid or not.
    def col_pos_invalid?(col_pos=@initial_position.col)
      !cols.include?(col_pos.to_s)
    end

    def invalid_tile_position?(pos)
      (pos < MIN_POS) || (pos > MAX_POS)
    end

    # Generating all the possible chess board positions
    def valid_boundaries
      rows.product(cols).collect{|ary| ary.join}.join(" ")
    end

    def valid_position?(row_pos, col_pos)
      !invalid_position?(row_pos, col_pos)
    end

    def invalid_position?(row_pos, col_pos)
      (row_pos.nil? || col_pos.nil?)
    end
end