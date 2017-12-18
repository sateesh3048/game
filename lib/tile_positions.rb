
module TilePositions
  # Defined methods for next possible moves of given chess piece types.
  def up
    {row:1, col:0}
  end

  def down
    {row:-1, col:0}
  end

  def left
    {row:0, col:-1}
  end

  def right
    {row:0, col:1}
  end

  def up_left(up_pos=1, left_pos=-1)
    {row:up_pos, col:left_pos}
  end

  def up_right(up_pos=1, right_pos= 1)
    {row:up_pos, col:right_pos}
  end

  def down_left(down_pos=-1, left_pos=-1)
    {row:down_pos, col:left_pos}
  end

  def down_right(down_pos=-1, right_pos=1)
    {row:down_pos, col:right_pos}
  end

  # Defining possible moves of piece type in diagonal way.
  def diagonal
    [up_left, up_right, down_left, down_right]
  end

  # Knight will move in L shape. So I am defining all possible moves Knight.
  def knight_diagonals
    [
      up_left(2,-1), up_right(2,1),
      down_left(-2,-1), down_right(-2,1),
      up_left(1,-2), down_left(-1,-2),
      up_right(1,2), down_right(-1,2)
    ]
  end

  
  def can_move_piece?
    @piece == :knight ? false : true
  end  
end