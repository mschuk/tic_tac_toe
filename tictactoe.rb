# Tic Tac Toe game

WINNING_COMBOS = [[1,2,3],[4,5,6],[7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

def initialize_board
  board = {}
  (1..9).each {|num| board[num] = ''}
  board
end

def print_board(board)
  system 'clear'
  puts "  #{board[1]}  | #{board[2]}  | #{board[3]}   "
  puts "----------------"
  puts "  #{board[4]}  | #{board[5]}  | #{board[6]}   "
  puts "----------------"
  puts "  #{board[7]}  | #{board[8]}  | #{board[9]}   "
end

def two_in_a_row(board)
  WINNING_COMBOS.each do |set|
    board_array = [board[set[0]], board[set[1]], board[set[2]]]
    if board_array.count('o') == 2 && board_array.count('') == 1
      return board.index('')
    elsif board_array.count('x') == 2 && board_array.count('') == 1
      return board.index('')
    end
  end
  nil
end

def computer_move(board)
  best_move = two_in_a_row(board)
  if board[5] == ''
    board[5] = 'o'
  elsif best_move
    board[best_move] = 'o'
  else
    possible_moves = board.select {|num, mark| mark == ''}
    board[possible_moves.keys.sample] = 'o'
  end
end

def check_winner(board)
  WINNING_COMBOS.each do |set|
    if board[set[0]] == 'x' && board[set[1]] == 'x' && board[set[2]] == 'x'
      return 'player'
    elsif board[set[0]] == 'o' && board[set[1]] == 'o' && board[set[2]] == 'o'
      return 'computer'
    end
  end
  nil
end

def player_move(num, board)
  board[num] = 'x'
end

def check_board?(board)
  board_keys = board.select { |num, mark| mark == ''}
  board_keys.empty?
end

loop do

  board = initialize_board

  puts "Let's play!"
  print_board(board)

  begin
    puts 'Pick a number 1-9 to mark the board'
    num = gets.chomp.to_i

    available_nums = board.select { |num, mark| mark == ''}
    until available_nums.include?(num)
      puts 'That number is not available.  Pick a number on the board that is empty.'
      num = gets.chomp.to_i
    end

    player_move(num, board)
    player_winner = check_winner(board)
    computer_move(board)
    board_winner = check_winner(board)
    board_full = check_board?(board)
    print_board(board)

  end until player_winner || board_winner || board_full

  if winner == 'player'
    puts 'You won!'
  elsif winner == 'computer'
    puts 'The Computer won!'
  else
    puts 'The board is full.'
  end

  puts 'Enter y if you would like to play again'
  play_again = gets.chomp

  break if play_again.downcase != 'y'
end
