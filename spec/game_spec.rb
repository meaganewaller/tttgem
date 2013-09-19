require 'game'
require 'ttt'

describe Game do
  let(:game) { Game.new }  

  context "#move" do
    it "makes a move" do
      game.move(0)
      game.ttt.board[0].should == 'x'
    end
  end

  context "#computer_move" do
    it "finds the best move for the comp when 'o'" do
      game.ttt = TTT.new(%w(x x - 
                            o o -
                            - - -), 'o')
      game.computer_move.should == 5
    end

    it "finds the best move for the comp when 'x'" do
      game.ttt = TTT.new(%w(x x -
                            o o -
                            - - -), 'x')
      game.computer_move.should == 2
    end
  end

  context "#over?" do
    it "knows when the game isn't over" do
      game.over?.should be_false
    end

    it "knows when the game is over b/c a win 'x'" do
      game.ttt = TTT.new(%w(x x x
                            - - -
                            - - -))
      game.over?.should be_true 
    end

    it "knows when the game is over b/c a win 'o'" do
      game.ttt = TTT.new(%w(o o o
                            - - -
                            - - -))
      game.over?.should be_true
    end

    it "knows when game is over b/c a tie" do
      game.ttt = TTT.new(%w(x o x
                            o x o
                            o x o))
      game.over?.should be_true
    end
  end
end
