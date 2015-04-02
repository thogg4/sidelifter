module Sidelifter
  module Error

    class NoUserDataVariable < StandardError
      def message
        "We couldn't find the USER_DATA environment variable"
      end
    end

  end
end
