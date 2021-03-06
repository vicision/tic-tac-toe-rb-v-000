WIN_COMBINATIONS = [
  [0,1,2], #Top Row
  [3,4,5], #Middle Row
  [6,7,8], #Bottom Row
  [0,3,6], #Left Column
  [1,4,7], #Middle Column
  [2,5,8], #Right Column
  [0,4,8], #Diagonal from top right
  [2,4,6] #Diagonal from top left
  ]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def move(board, position, current_player = "X")
  board[position.to_i-1] = current_player
end

def position_taken?(board, position)
  board[position] != " " && board[position] != ""
end

def valid_move?(board, position)
  position.to_i.between?(1,9) && !position_taken?(board, position.to_i-1)
end

def turn(board)
  puts "#{current_player(board)}, please enter a valid move for positions 1-9:"
  position = gets.strip
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    puts "Invalid move."
    turn(board)
  end
  display_board(board)
end

def turn_count(board)
  turns = 0
  board.each do |position|
    if position == "X" || position == "O"
      turns += 1
    end
  end
  turns
end

def won?(board)
  WIN_COMBINATIONS.detect do |win_comb|
    if (win_comb.any? {|position| position_taken?(board, position)}) && (board[win_comb[0]] == board[win_comb[1]] && board[win_comb[0]] == board[win_comb[2]])
      win_comb
    end
  end
end

def full?(board)
  board.none? do |position|
    position == " "
  end
end

def draw?(board)
  full?(board) && !(won?(board))
end

def over?(board)
  full?(board) || won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    board[won?(board)[0]]
  end
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
    puts "You've won the game!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
