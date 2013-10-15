module TicTacToe
  class AI
    attr_reader :mark
    attr_accessor :difficulty

    def initialize(mark, difficulty = :unbeatable_ai)
      @mark = mark
      @difficulty = difficulty
    end

    def make_move(board)
      move = { :difficulty => @difficulty,
               :board => board,
               :mark => @mark }
      AIRules::Factory.get(move)
    end
  end
end
