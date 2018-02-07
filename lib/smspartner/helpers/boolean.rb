module Smspartner
  module Helpers
    class Boolean

      def self.valid?(value)
        value == true || value == false
      end

    end
  end
end
