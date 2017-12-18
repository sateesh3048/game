module BaseData
  # Using struct to store col and row info of given position.
  Position = Struct.new(:col, :row)
  private
    # Defining chess board rows
    def rows
      ('1'..'8').to_a
    end

    # Defining chess board columns
    def cols
      ('a'..'h').to_a
    end
end