require 'pry'
module TicTacToe
  class AIEngine
    MAX_SCORE = 100
    MIN_SCORE = -100
    TIED_SCORE = 0

    def self.make_move(board, mark)
      best_score = MIN_SCORE
      best_space = 0
      opponent_mark = mark == "X" ? "O" : "X"

      board.empty_spaces.each do |space|
        board.place_move(mark, space)
        score = MinScore.new(board, opponent_mark, 0, MIN_SCORE, MAX_SCORE, -1).minimax
        board.undo_move(space)

        if score > best_score
          best_score = score
          best_space = space
        end
      end
      return best_space
    end
 end


  class Score

    def initialize(board, mark, depth, score_min, score_max, color)
      @board, @mark, @depth, @min, @max, @color = board, mark, depth, score_min, score_max, color
    end

    def check_game_state(board, mark, depth)
      return AIEngine::TIED_SCORE if board.tied_game?
      return AIEngine::MAX_SCORE + depth if board.winner == mark
      AIEngine::MIN_SCORE + depth
    end

    def game_done?(board, depth)
      board.has_winner? || board.tied_game? || depth == 6
    end

    protected
    attr_accessor :board, :mark, :depth, :min, :max, :color

  end

  class MinScore < Score

    def minimax
      opponent_mark = mark == "X" ? "O" : "X"

      return check_game_state(board, mark, depth) * color if game_done?(board, depth)

      score_max = nil
      board.empty_spaces.each do |spaces|
        board.place_move(mark, spaces)
        score_max = [max, MaxScore.new(board, opponent_mark, depth + 1, min, max, -color).minimax].min
        board.undo_move(spaces)
        break if min >= score_max
      end


      return score_max
    end
  end

  class MaxScore < Score

    def minimax
      opponent_mark = mark == "X" ? "O" : "X"

      return check_game_state(board, mark, depth) * color if game_done?(board, depth)

      score_min = nil
      board.empty_spaces.each do |spaces|
        board.place_move(mark, spaces)
        score_min = [min, MinScore.new(board, opponent_mark, depth + 1, min, max, -color).minimax].max
        board.undo_move(spaces)
        break if score_min >= max
      end
      return score_min
    end
  end
end
