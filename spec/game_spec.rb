require "spec_helper"
RSpec.describe Game do
  before(:all) do 
    @data = {
      knight: [
        {"position" => "a1", expected: ["b3", "c2"]},
        {"position" => "a8", expected: ["b6", "c7"]},
        {"position" => "h1", expected: ["f2", "g3"]},
        {"position" => "h8", expected: ["f7", "g6"]},
        {"position" => "d5", expected: ["b4", "b6", "c3", "c7", "e3", "e7", "f4", "f6"]},
        {"position" => "d2", expected: ["b1", "b3", "c4", "e4", "f1", "f3"]},
        {"position" => "e3", expected: ["c2", "c4", "d1", "d5","f1", "f5", "g2", "g4"]},
        {"position" => "g7", expected: ["e6", "e8", "f5", "h5"]},
        {"position" => "b4", expected: ["a2", "a6", "c2", "c6","d3", "d5"]},
        {"position" => "c6", expected: ["a5", "a7", "b4", "b8","d4", "d8", "e5", "e7"]},
        {"position" => "f4", expected: ["d3", "d5", "e2", "e6", "g2", "g6", "h3", "h5"]},
      ],
      rook: [
        {"position" => "a1", expected: ["a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "c1", "d1","e1", "f1", "g1","h1"]},
        {"position" => "a8", expected: ["a1", "a2", "a3", "a4","a5", "a6", "a7","b8", "c8", "d8", "e8", "f8", "g8", "h8"]},
        {"position" => "h1", expected: ["a1","b1", "c1", "d1", "e1", "f1", "g1","h2", "h3", "h4","h5", "h6", "h7","h8"]},
        {"position" => "h8", expected: ["a8","b8", "c8", "d8", "e8", "f8", "g8","h1","h2", "h3", "h4","h5", "h6", "h7"]},
        {"position" => "d5", expected: ["a5","b5", "c5", "e5", "f5", "g5","h5","d1","d2", "d3", "d4", "d6", "d7", "d8"]},
        {"position" => "e7", expected: ["a7","b7", "c7", "d7", "f7", "g7","h7","e1","e2", "e3", "e4", "e5", "e6", "e8"]},
        {"position" => "f2", expected: ["a2","b2", "c2", "d2", "e2", "g2","h2","f1", "f3", "f4","f5", "f6", "f7", "f8"]},
        {"position" => "g6", expected: ["a6","b6", "c6", "d6", "e6", "f6", "h6","g1", "g2", "g3", "g4", "g5", "g7", "g8"]},
        {"position" => "b1", expected: ["a1", "c1", "d1", "e1", "f1", "g1", "h1","b2", "b3", "b4", "b5", "b6", "b7", "b8"]},
        {"position" => "c3", expected: ["a3", "b3", "d3", "e3", "f3", "g3", "h3","c1", "c2", "c4", "c5", "c6", "c7", "c8"]},
        {"position" => "e4", expected: ["a4","b4", "c4", "d4", "f4", "g4", "h4","e1", "e2", "e3", "e5", "e6", "e7", "e8"]}
        ],
      queen: [
        {"position" => "a1", expected: ["a2", "a3", "a4", "a5", "a6", "a7", "a8", "b1", "c1", "d1","e1", "f1", "g1","h1", "b2", "c3", "d4", "e5", "f6", "g7", "h8"]},
        {"position" => "a8", expected: ["a1", "a2", "a3", "a4","a5", "a6", "a7","b8", "c8", "d8", "e8", "f8", "g8", "h8", "h1", "g2", "f3", "e4", "d5", "c6", "b7"]},
        {"position" => "h1", expected: ["a1","b1", "c1", "d1", "e1", "f1", "g1","h2", "h3", "h4","h5", "h6", "h7","h8", "a8", "b7", "c6", "d5", "e4", "f3", "g2"]},
        {"position" => "h8", expected: ["a8","b8", "c8", "d8", "e8", "f8", "g8","h1","h2", "h3", "h4","h5", "h6", "h7", "a1", "b2", "c3", "d4", "e5", "f6", "g7"]},
        {"position" => "d5", expected: ["a5","b5", "c5", "e5", "f5", "g5","h5","d1","d2", "d3", "d4", "d6", "d7", "d8", "a2","b3","c4", "e6", "f7", "g8", "c6" ,"b7", "a8", "e4", "f3", "g2", "h1"]},
        {"position" => "e2", expected: ["e1", "e3", "e4", "e5", "e6", "e7", "e8","a2", "b2", "c2", "d2", "f2", "g2", "h2","d1", "f3", "g4", "h5", "f1", "d3", "c4", "b5", "a6"]},
        {"position" => "f4", expected: ["f1", "f2", "f3", "f5", "f6", "f7", "f8","a4", "b4", "c4", "d4", "e4", "g4", "h4","e5", "d6", "c7", "b8", "g3", "h2","g5", "h6", "e3", "d2", "c1"]},
        {"position" => "g7", expected: ["g1", "g2", "g3", "g4", "g5", "g6",  "g8","a7", "b7", "c7", "d7", "e7",  "f7", "h7","a1", "b2", "c3", "d4", "e5", "f6","h8","f8", "h6"]},
        {"position" => "b3", expected: ["b1", "b2", "b4", "b5", "b6", "b7", "b8","a3", "c3", "d3", "e3", "f3", "g3", "h3","a2", "c4", "d5", "e6", "f7", "g8","c2", "d1", "a4"]},
        {"position" => "c6", expected: ["c1", "c2","c3","c4", "c5",  "c7", "c8","a6", "b6", "d6", "e6", "f6", "g6", "h6","d7", "e8", "b5", "a4", "b7", "a8", "d5", "e4", "f3", "g2", "h1"]},
      ]
    }
  end
  describe "Validating user input" do 
    context "When passing invalid input" do 
      it "returns error message when passing invalid chess piece type" do 
        input = {"piece" => "test", "position" => "a1"}
        expect { Game::ChessBoard.new(input).response}.to output(/Please enter valid chess piece type/).to_stdout
      end

      it "returns error message when passing invalid position" do 
        input = {"piece" => "queen", "position" => "k1"}
        expect { Game::ChessBoard.new(input).response}.to output(/Please enter valid chess piece position/).to_stdout
      end
    end

    context "When passing valid input" do
      context "When passing Queen as chess piece type" do 
        it "returns next possible moves for queen" do 
          @data[:queen].each do |hsh|
            input = {"piece" => "Queen", "position" => hsh["position"]}
            output = Game::ChessBoard.new(input).response.split(",").sort
            expect(output).to eq(hsh[:expected].sort)
          end
        end 
      end
      context "When passing Knight as chess piece type" do 
        it "returns next possible moves for knight" do 
          @data[:knight].each do |hsh|
            input = {"piece" => "Knight", "position" => hsh["position"]}
            output = Game::ChessBoard.new(input).response.split(",").sort
            expect(output).to eq(hsh[:expected])
          end
        end 
      end
      context "When passing Rook as chess piece type" do 
        it "returns next possible moves for rook" do 
          @data[:rook].each do |hsh|
            input = {"piece" => "Rook", "position" => hsh["position"]}
            output = Game::ChessBoard.new(input).response.split(",").sort
            expect(output).to eq(hsh[:expected].sort)
          end
        end 
      end
    end
  end
end
