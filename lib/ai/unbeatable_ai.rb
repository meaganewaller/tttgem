module TicTacToe
  module AIRules
    class UnbeatableAI
      Infinity = 100
      Negative_Infinity = -100

      def self.make_move(board, mark)
        best_score = Negative_Infinity
        best_space = 0
        opponent_mark = mark == "X" ? "O" : "X"

        board.empty_spaces.each do |space|
          board.place_move(mark, space)
          score = minimax(board, opponent_mark, 0, Negative_Infinity, Infinity, false, -1)
          board.undo_move(space)

          if score > best_score
            best_score = score
            best_space = space
          end
        end
        return best_space
      end

      def self.minimax(board, mark, depth, score_min, score_max, max_player, color)
        opponent_mark = mark == "X" ? "O" : "X"

        return check_game_state(board, mark, depth) * color if game_done?(board, depth)

        if max_player
          board.empty_spaces.each do |spaces|
            board.place_move(mark, spaces)
            score_min = [score_min, minimax(board, opponent_mark, depth + 1, score_max, score_min, !(max_player), -color)].max
            board.undo_move(spaces)
            break if score_min >= score_max
          end
          return score_min
        else
          board.empty_spaces.each do |spaces|
            board.place_move(mark, spaces)
            score_max = [score_max, minimax(board, opponent_mark, depth + 1, score_max, score_min, !(max_player), -color)].min
            board.undo_move(spaces)
            break if score_min >= score_max
          end
          return score_max
        end
      end

      def self.check_game_state(board, mark, depth)
        return 0 if board.tied_game?
        return 100 + depth if board.winner == mark
        -100 + depth
      end

      def self.game_done?(board, depth)
        board.has_winner? || board.tied_game? || depth == 6
      end
    end
  end
end
