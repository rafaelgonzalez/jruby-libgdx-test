require 'direction'

module Skills
  class Base
    def resources_available?
      costs.all? do |resource, cost|
        character.public_send("#{resource}") >= cost
      end
    end

    def spend_resources!
      costs.each do |resource, cost|
        character.public_send("spend_#{resource}!", cost)
      end
    end

    def costs
      raise "Skills::Base#costs must be implemented."
    end
  end
end

require_relative 'skills/move'
require_relative 'skills/unarmed_attack'
