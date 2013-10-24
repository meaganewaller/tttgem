module TicTacToe
  class PlayerFactory
    def self.create(input)
      case input[:type]
      when :ai
        AI.new(input[:mark])
      when :human
        Human.new(input[:mark])
      else
        raise "Invalid Player Type"
      end
    end
  end
end
