
# Please don't get scared by how messy the code is in the other file.
# I know I am using global variables I currently can't get it to work properly without them.

require_relative 'shape_swipe_4.0.rb'
require 'io/console'

grid = ["💪", "🍴", "🏋", "💉"]
valid_inputs = ["w", "a", "s", "d"]
play = ShapeSwipe.new

play.welcome
print "Would you like to play? [y,n]:"
answer = gets.chomp.downcase
play.valid_start?(answer)

play.start(answer, grid, valid_inputs)
