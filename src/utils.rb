module Utils

  ##
  # Prints query to standard oputput and get user input.
  #
  # If a block is given, checks acceptance with the (bool) result of the block.
  # Loops untill acceptable value is inputed.
  def self.prompt(q, default=nil)
    begin
      puts "#{q}#{default && " [#{default}]"}"
      answer = gets.chomp
      answer = answer.empty? && default || answer # set to default if answer is empty (and default is non nil)
      accepted = block_given? && yield(answer)
      puts "-- '#{answer}' is not acceptable. --" if block_given? && !accepted
    end while block_given? && !accepted

    answer
  end
end
