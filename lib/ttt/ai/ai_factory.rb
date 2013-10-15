module TicTacToe
  module AIRules
    class Factory
      def self.get(move)
        case move[:difficulty]
        when :unbeatable_ai
          UnbeatableAI.make_move(move[:board], move[:mark])
        end
      end
    end
  end
end
