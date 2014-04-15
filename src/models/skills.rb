module Skills
  class Base
    def resource_available?
      character.public_send("#{resource}") >= cost
    end

    def spend!
      character.public_send("spend_#{resource}!", cost)
    end

    def resource
      raise NotImplementedError.new("Skills::Base#resource must be implemented.")
    end

    def cost
      raise NotImplementedError.new("Skills::Base#cost must be implemented.")
    end

    def usable?
      raise NotImplementedError.new("Skills::Base#usable? must be implemented.")
    end

    private

    def log_message(message)
      if character.actor
        character.actor.get_stage.combat_logger.add_message(message)
      else
        puts message
      end
    end
  end
end

require_relative 'skills/move'
require_relative 'skills/unarmed_attack'
