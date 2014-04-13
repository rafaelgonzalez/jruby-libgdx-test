class Character
  extend Forwardable

  attr_accessor :actor, :current_direction, :current_tile, :destination_tile, :health
  attr_reader :armor

  def_delegators :@current_tile, :dungeon_level, :x_position, :y_position

  MAX_HEALTH = 20
  BASE_ARMOR = 0

  def initialize
    @actor = nil

    @health = MAX_HEALTH
    @armor = BASE_ARMOR

    @current_direction = Direction::RIGHT

    @current_tile = nil
    @destination_tile = nil
  end

  def current_tile=(new_tile)
    @current_tile.character = nil unless @current_tile.nil?
    new_tile.character = self

    @current_tile = @destination_tile = new_tile
  end

  # Public: Use a Skill corresponding to the given name.
  #
  # skill_name - Name of the Skill
  #
  # Returns nothing.
  def use_skill!(skill_name)
    skill_class = "Skills::#{skill_name.to_s.camelize}".constantize
    skill_class.new(self, @current_tile).execute!
  end
end
