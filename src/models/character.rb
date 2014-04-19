class Character
  extend Forwardable

  attr_accessor :actor, :current_direction, :current_tile, :destination_tile
  attr_reader :armor, :name, :maximum_health, :health, :maximum_stamina, :stamina,
              :maximum_mana, :mana, :maximum_action_points, :action_points

  def_delegators :@current_tile, :dungeon_level, :x_position, :y_position

  BASE_MAX_HEALTH = 5
  BASE_STAMINA = 5
  BASE_MANA = 0
  BASE_ACTION_POINTS = 5

  BASE_ARMOR = 0

  DEFAULT_DIRECTION = Direction::RIGHT

  def initialize(name)
    @name = name

    @actor = nil

    @maximum_stamina = BASE_STAMINA
    @stamina = BASE_STAMINA

    @maximum_mana = BASE_MANA
    @mana = BASE_MANA

    @maximum_health = BASE_MAX_HEALTH
    @health = BASE_MAX_HEALTH

    @maximum_action_points = BASE_ACTION_POINTS
    @action_points = BASE_ACTION_POINTS

    @armor = BASE_ARMOR

    @current_direction = DEFAULT_DIRECTION

    @current_tile = nil
    @destination_tile = nil
  end

  def current_tile=(new_tile)
    @current_tile.character = nil unless @current_tile.nil?
    new_tile.character = self

    @current_tile = @destination_tile = new_tile
  end

  def take_damage!(damage)
    total_damage = damage - armor

    if total_damage <= 0
      log_message(I18n.t('models.character.take_damage.no_damage', character_name: name))
    else
      @health -= total_damage
      @health = 0 if @health < 0

      log_message(I18n.t('models.character.take_damage.damage',
                         character_name: name,
                         damage: total_damage))

      log_message(I18n.t('models.character.take_damage.hp_left',
                         character_name: destination_tile.character.name,
                         health: destination_tile.character.health))
    end
  end

  def armor
    BASE_ARMOR
  end

  def alive?
    health > 0
  end

  def playable?
    alive?
  end

  def spend_stamina!(amount)
    @stamina -= amount
    @stamina = 0 if @stamina < 0
    log_message("#{name} has #{@stamina} stamina left.")
  end

  def spend_mana!(amount)
    @mana -= amount
    @mana = 0 if @mana < 0
  end

  def reset_for_new_turn!
    if alive?
      @stamina = @maximum_stamina
      @mana = @maximum_mana
    end
  end

  # Public: Use a Skill corresponding to the given name.
  #
  # skill_name - Name of the Skill
  #
  # Returns nothing.
  def use_skill!(skill_name)
    skill_class = "Skills::#{skill_name.to_s.camelize}".constantize
    skill_class.new(self).execute!
  end

  private

  def log_message(message)
    actor.nil? ? puts(message) : actor.log_message(message)
  end
end
