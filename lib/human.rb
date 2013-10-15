module TicTacToe
  class Human
    attr_reader :mark

    def initialize(mark)
      @mark = mark
    end

    def make_move(space, board)
      board.place_move(@mark, space)
    end
  end
end
