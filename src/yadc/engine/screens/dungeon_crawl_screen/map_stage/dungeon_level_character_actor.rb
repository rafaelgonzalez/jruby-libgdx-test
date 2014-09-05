require 'forwardable'

require_relative 'dungeon_level_character_actor/click_listener'
require_relative 'dungeon_level_character_actor/input_listener'
require_relative 'dungeon_level_character_actor/input_translator'
require_relative 'dungeon_level_character_actor/renderer'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonLevelCharacterActor < Actor
        include Renderer

        extend Forwardable

        attr_accessor :current_action
        attr_reader :input_translator, :character

        def_delegators :@character, :current_tile, :destination_tile, :x_position, :y_position,
                                    :current_direction, :armor, :health, :use_skill!, :alive?,
                                    :playable?, :reset_for_new_turn!, :name, :maximum_stamina,
                                    :maximum_mana, :stamina, :mana, :maximum_health,
                                    :maximum_action_points, :action_points, :team

        def initialize(character)
          super()

          @character = character
          character.actor = self

          @current_action = Yadc::Core::Character::Action::STAND

          @state_time = 0.0

          initialize_rendering

          set_height(LpcSpriteSheetLoader::SPRITE_HEIGHT)
          set_width(LpcSpriteSheetLoader::SPRITE_WIDTH)

          @input_translator = InputTranslator.new(self)

          add_listener(InputListener.new(self))
          add_listener(ClickListener.new(self))
        end

        # Public: Updates the DungeonLevelCharacterActor.
        # Overrides Actor#act.
        #
        # Returns nothing.
        def act(delta_time)
          @state_time += delta_time
          super

          @current_action = Yadc::Core::Character::Action::DEATH unless alive?
        end

        def current_tile=(new_tile)
          character.current_tile = new_tile

          set_x(screen_x_position)
          set_y(screen_y_position)
        end

        # Public: Determines if the Character is moving.
        #
        # Returns a Boolean.
        def is_moving?
          @current_action == Yadc::Core::Character::Action::WALK
        end
      end
    end
  end
end
