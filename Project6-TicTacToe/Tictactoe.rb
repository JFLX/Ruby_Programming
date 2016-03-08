require './Array_extensions.rb'

module Tictactoe
	class Player
		@@player_number = 1
		@@teams = ["X", "O"]
		attr_reader :name, :team
		def initialize(name=get_name, team=set_team)
			@name = name
			@team = team
			@@player_number += 1
			puts "#{@name} will play with the #{@team}"
		end

		def get_name
			puts "Player#{@@player_number} write your name"
			gets.chomp
		end

		def set_team
			@@teams.shuffle!.pop
		end
	end

	class Square
		attr_accessor :value
		def initialize(value="") 
			@value = value
		end
	end

	class Board
		attr_reader :grid
		def initialize(grid=empty_grid)
			@grid = grid
		end

		def empty_grid
			Array.new(3) { Array.new(3) { Square.new } }
		end

		def display_grid
			puts "  A   B   C"
	      	grid.each_with_index do |row, row_number|
	      		row_number += 1
	        	puts "#{row_number} " << row.map { |x| x.value.empty? ? " " : x.value }.join(" | ")
	        	puts " ---|---|---" unless row_number == 3
	      	end
	    end

		def get_square(x, y)
			grid[y][x]
		end

		def set_square(x, y, value)
			get_square(x, y).value = value
		end

		def game_over?
			return winner? if winner?
			return draw? if draw?
			false
		end

		def draw?
			return true if grid.flatten.map { |square| square.value }.none_empty?
			false
		end

		def winner?
			winning_rows.each do |row|
				next if get_row_values(row).any_empty?
				return true if get_row_values(row).all_same?
			end
			false
		end

		def winning_rows
			grid + grid.transpose + diagonals
		end

		def diagonals
			[[get_square(0, 0), get_square(1, 1), get_square(2, 2)], 
			[get_square(2, 0), get_square(1, 1), get_square(0, 2)]]
		end

		def get_row_values(row)
			row.map { |square| square.value }
		end
	end

	class Game
		attr_reader :players, :board, :current_player, :other_player
		def initialize(players = [Player.new, Player.new], board = Board.new)
			@players = players
			@board = board
			@current_player, @other_player = players.shuffle
		end

		def switch_players
			@current_player, @other_player = @other_player, @current_player
		end

		def solicit_move
			puts "#{@current_player.name} enter a position from A1 to C3 to make your move:"
		end

		def get_move(position = gets.chomp)
			position.upcase.scan(/\w/)
		end

		def valid_move_input?(move)
			return true if ("A".."C").include?(move[0]) && ("1".."3").include?(move[1])
			false
		end

		def solicit_valid_input
			puts "#{@current_player.name} you must enter a position from A1 to C3!"
		end

		def move_to_coordinate(move)
			xy = { "A" => 0, "B" => 1, "C" => 2, "1" => 0, "2" => 1, "3" => 2 }
			move.map { |move| xy.values_at(move) }.flatten
		end

		def valid_coordinate?(move)
			x, y = move_to_coordinate(move)
			return true if board.get_square(x, y).value.empty?
			false
		end

		def solicit_valid_coordinate
			puts "#{@current_player.name} this position is taken! Choose another position!"
		end

		def game_over_message
			puts "#{current_player.name} have won the game!" if board.game_over? == board.winner?
			puts "The game ended in a tie!" if board.game_over? == board.draw?
		end

		def play
			until board.game_over?
				board.display_grid
				solicit_move
				move = []
				until valid_move_input?(move) && valid_coordinate?(move)
					move = get_move
					unless valid_move_input?(move)
						solicit_valid_input
						next
					end
					unless valid_coordinate?(move)
						solicit_valid_coordinate
						next
					end
				end
				x, y = move_to_coordinate(move)
				board.set_square(x, y, current_player.team)
				if board.game_over?
					board.display_grid
					game_over_message
				end
				switch_players
			end
		end

	end
end
include Tictactoe

puts "Welcome to TicTacToe!"
game = Game.new
game.play
