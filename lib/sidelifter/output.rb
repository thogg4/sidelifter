module Sidelifter
  module Output

    def shout(message)
      # lines are always 80 characters
      message_size = message.size
      stars = '*' * (77 - message_size)
      puts "+ #{message} #{stars}"
    end

  end
end
