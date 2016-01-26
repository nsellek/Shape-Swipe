class ShapeSwipe

  def game_board(grid, number) #works
    puts "Instructions:"
    puts "W to match up"
    puts "A to match left"
    puts "S to match down"
    puts "D to match right"
    puts "     #{grid[0]}     "
    puts ""
    puts " #{grid[1]}   #{grid[number]}   #{grid[2]} "
    puts ""
    puts "     #{grid[3]}     "
  end

  def shuffle(grid) #works
    grid.shuffle
  end

  def user_input(valid_inputs) #works
    print "Match the middle object with it's corresponding object:"
    valid_user_input = STDIN.getch
    until valid_inputs.include?(valid_user_input)
      puts ""
      print "Please put w, a, s, or d only:"
      valid_user_input = STDIN.getch
    end
    return valid_user_input
  end

  def correct_match?(number, input)#works
    %w(w a d s)[number] == input
  end

  def welcome #works
    puts "Welcome to\n
    ███████╗██╗  ██╗ █████╗ ██████╗ ███████╗    ███████╗██╗    ██╗██╗██████╗ ███████╗
    ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔════╝    ██╔════╝██║    ██║██║██╔══██╗██╔════╝
    ███████╗███████║███████║██████╔╝█████╗      ███████╗██║ █╗ ██║██║██████╔╝█████╗
    ╚════██║██╔══██║██╔══██║██╔═══╝ ██╔══╝      ╚════██║██║███╗██║██║██╔═══╝ ██╔══╝
    ███████║██║  ██║██║  ██║██║     ███████╗    ███████║╚███╔███╔╝██║██║     ███████╗
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝    ╚══════╝ ╚══╝╚══╝ ╚═╝╚═╝     ╚══════╝
    DEVELOPED BY NICHOLAS SELLEK                      "
  end

  def random_number #works
    number = rand(0..3)
  end

  def lost #works
    puts ""
    puts "Ouch, sorry that wasn't the right object!"
    # puts "You final score is: #{score}"
    puts "Better luck next time!"
  end

  def first_run (grid) #works
    system('clear')
    welcome
    random_number
    game_board(shuffle(grid))
    user_input
  end

  def continuous_run (grid, score, number) #works
    system('clear')
    welcome
    game_board(shuffle(grid), number)
    puts "Score #{score}"
    #user_input(valid_inputs)
  end

  def valid_start? (answer) #works
    until answer == "y" || answer == "n"
      print "Please only use y or n: "
      answer = gets.chomp.downcase
    end
  end

  def start (answer, grid, valid_inputs) #works
    if answer == "y"
      puts "How much time would you like to play for?"
      print "Time is in seconds: "
      seconds = gets.chomp.to_i
      valid_time?(seconds)
      goplay(grid, valid_inputs, seconds)
    else
      puts "Ok, maybe another time 😢"
    end
  end

  def goplay(grid, valid_inputs, seconds) #works
    playing = true
    score = 0
    start_time = Time.now
    time {
      while playing
        break if Time.now - start_time >= seconds
        number = random_number
        continuous_run(grid, score, number)
        input = user_input(valid_inputs)
        if correct_match?(number, input)
          score += 1
        else
          # lost
          playing = false
        end
      end
    }
    puts "Your final score is: #{score}"
    print "Play Again? [y,n]: "
    play_again = gets.chomp.downcase
    while !valid_start?(play_again)
      print "Please only use y or n:"
      play_again = gets.chomp.downcase
    end
    if play_again == "y"
      goplay(grid, valid_inputs, seconds)
    else
      puts "Thanks for playing!"
      puts "See you again soon 🙂"
    end
  end

  def valid_time? (seconds)
    until seconds > 0
      print "Please only use numbers: "
      seconds = gets.chomp.to_i
    end
  end

  def time
    # start_time = Time.now
    result = yield
    # end_time = Time.now
    puts
    puts "Game Over!"
    result
  end
end
