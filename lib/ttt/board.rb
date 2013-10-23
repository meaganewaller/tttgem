module TicTacToe
  class Board
    attr_accessor :spaces, :solutions

    def initialize
      @spaces = %w[1 2 3 4 5 6 7 8 9]
      winning_solutions
    end

    def self.parse(board)
      new_board_for_translation = self.new
      translated_board_spaces = []
      new_spaces_for_translation = board.split('')
      new_spaces_for_translation.each_index do |index|
        if new_spaces_for_translation[index] == '_' || new_spaces_for_translation[index].to_i != 0
          translated_board_spaces << (index + 1).to_s
        else
          translated_board_spaces << new_spaces_for_translation[index]
        end
      end
      new_board_for_translation.spaces = translated_board_spaces
      new_board_for_translation
    end

    def to_s
      @spaces.join
    end

    def get(space)
      @spaces[(space.to_i)-1]
    end

    def place_move(piece, *indices)
      indices.each do |space|
        @spaces[(space.to_i)-1] = piece
      end
    end

    def undo_move(space)
      @spaces[(space.to_i)-1] = space.to_s
    end

    def is_space_taken?(space)
      @spaces[(space.to_i) - 1].to_i == 0
    end

    def tied_game?
      full_board? && !has_winner?
    end

    def full_board?
      (@spaces.count { |x| x == 'X' } + @spaces.count { |x| x == 'O' }) == 9
    end

    def is_board_empty?
      !@spaces.include?("X") && !@spaces.include?("O")
    end

    def has_winner?
      @solutions.find { |sol| is_solution_found?(sol)}
    end

    def is_solution_found?(spaces)
      spaces.map { |s| @spaces[s-1]}.uniq.length == 1 
    end

    def translate_board_to_string 
      @spaces.reduce("") do |blank_spaces, spaces|
        if !spaces.to_i.zero?
          blank_spaces << '_'
        else
          blank_spaces << spaces
        end
      end
    end

    def empty_spaces
      @spaces.select { |x| x.to_i != 0}
    end

    def row_win
      (@spaces.map { |space| space.to_i }).each_slice(3) { |nums| @solutions.push(nums)}
    end

    def column_win
      3.times do |check|
        ((check+1)..(9)).step(3).each_slice(3) do |nums|
          @solutions.push(nums)
        end
      end
    end

    def diagonal_win
      (1..(9)).step(4).each_slice(3) do |nums|
        @solutions.push(nums)
      end
      ((3)..(9)-1).step(2).each_slice(3) do |nums|
        @solutions.push(nums)
      end
    end

    def winning_solutions
      @solutions = []
      row_win
      column_win
      diagonal_win
    end

    def winner
      winner = ""
      @solutions.each { |sol| winner = @spaces[sol[0]-1] if is_solution_found?(sol)}
      winner
    end
  end
end
