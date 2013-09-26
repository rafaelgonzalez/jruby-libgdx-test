class Dungeon::Level::Character
  module InputTranslator

    attr_accessor :current_action
    attr_reader :current_direction

    def initialize_input
      load_key_bindings
    end

    # Public: Transforms the Character according to the given user's input.
    #
    # Returns nothing.
    def transform_from_input!
      @current_direction = direction_from_input
      @current_action = action_from_input
    end

    # Public: Determines if the Character wants to move.
    #
    # Returns a Boolean.
    def wants_to_move?
      @key_bindings.invoked(:directions).any?
    end

    # Public: Determines if the Character is moving.
    #
    # Returns a Boolean.
    def is_moving?
      @current_action == CharacterAction::WALK
    end


    private

    # Internal: Gets the Character's current action according to the given input.
    #
    # Returns a CharacterAction constant.
    def action_from_input
      return CharacterAction::WALK if is_moving? or wants_to_move?
      return CharacterAction::STAND
    end

    # Internal: Gets the Character's facing direction according to the given input.
    #
    # Returns a Direction constant.
    def direction_from_input
      if wants_to_move? and !is_moving?
        return @key_bindings.invoked(:directions).first
      else
        return @current_direction
      end
    end

    def load_key_bindings
      @key_bindings = KeyBinding::Character.new
    end
  end
end