# This class is perhaps overkill for this use case as it stands but I wanted to
# Demonstrate how I've historically used service objects to encapsulate complex business logic.
# As the requirements grow there is a centralised, reusable class that is responsible for creating Messages.
module Messages
  class Creator < Base
    def initialize(params)
      @params = params
    end
  
    def call
      message = Message.new(@params)

      if message.save
        message.broadcast_append_to message.chat_room, partial: "messages/message", locals: { message: message }
    
        Result.new(true, message)
      else
        Result.new(false, message)
      end
    end

    class Result
      attr_reader :message

      def initialize(success, message)
        @success = success
        @message = message
      end

      def success?
        @success
      end
    end
  end
end