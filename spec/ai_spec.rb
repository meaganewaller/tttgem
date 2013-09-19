require 'ttt'
require 'ai'

describe AI do
  let(:ai) { AI.new }
  let(:ttt) { TTT.new }

  context "#minimax" do
    it "returns 100 for an 'x' win" do
      test = TTT.new(%w(x x x
                        - - -
                        - - -))
      ai.minimax(test).should == 100
      
    end

    it "returns -100 for an 'o' win" do
      test = TTT.new(%w(o o o
                        - - -
                        - - -))
      ai.minimax(test).should == -100

    end

    it "returns 0 for a tied game" do
      test = TTT.new(%w(x o x
                        o x o
                        o x o))
      ai.minimax(test).should == 0
    end

    it "determines a win for x in 1 move" do
      test = TTT.new(%w(x x -
                        - - -
                        - - -))
      ai.minimax(test).should == 100 + test.count_empty_spaces
    end

    it "determines a win for o in 1 move" do
      TTT.new(%w(o o -
                 - - -
                 - - -), 'o')
      ai.minimax.should == -100 - ttt.count_empty_spaces
    end
  end

  context "#best_move" do
    it "finds the best move for x" do
      TTT.new(%w(x - x
                 o o x
                 o x o), 'x').best_move.should == 1
    end

    it "finds the best move for o" do
      TTT.new(%w(o - o
                 x x o
                 x o x), 'o').best_move.should == 1
    end
  end
end

