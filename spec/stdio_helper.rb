module StdIOHelper
  def stash_argv
    # Spec files seem to receive the arguments of the rspec command (e.g. rspec --format d).
    # If we're messing with $stdin, we need to clear the arguments array, otherwise the script
    # will start reading the arguments, instead of our provided values.
    @argv = ARGV.dup
    ARGV.clear
  end

  def restore_argv
    # Put everything back where we found it
    ARGV.concat(@argv)
  end
end
