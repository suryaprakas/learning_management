module Lms
    module Exception
      class InvalidParameter < ArgumentError; end
      class InvalidLogin < StandardError; end
      class InvalidRequest < StandardError; end
    end
end