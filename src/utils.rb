# Place to hold utility functions
module Utils
  ##
  # Prints query to standard oputput and get user input.
  #
  # If a block is given, checks acceptance with the (bool) result of the block.
  # Loops untill acceptable value is inputed.
  def self.prompt(query, default = nil)
    loop do
      puts "#{query}#{default && " [#{default}]"}"
      answer = gets.chomp
      answer = answer.empty? && default || answer # set to default if answer is empty (and default is non nil)
      break answer unless block_given?

      accepted = yield(answer)
      break answer if accepted

      puts "-- '#{answer}' is not acceptable. --"
    end
  end
end
