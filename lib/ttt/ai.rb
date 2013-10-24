module TicTacToe
  class AI
    attr_reader :mark

    def initialize(mark)
      @mark = mark
    end

    def make_move(board)
      move = { :board => board,
               :mark => @mark }
      AIEngine.make_move(move[:board], move[:mark])
    end
  end
end
