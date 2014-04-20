require_relative 'dungeon_level_actor/input_listener'

class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonLevelActor < Group
        TILE_WIDTH = 32
        TILE_HEIGHT = 32

        attr_accessor :player_team
        attr_reader :dungeon_level, :tiled_map_renderer

        def initialize(dungeon_level, tiled_map)
          super()

          set_name 'Level characters'

          @dungeon_level = dungeon_level

          @tiled_map_renderer = OrthogonalTiledMapRenderer.new(tiled_map)

          @character_actors = []
          @controlled_character_index = 0

          add_listener(InputListener.new(self))
        end

        # Public: Spawns a DungeonLevelCharacterActor into the map.
        # Checks a Tile exists at the given coordinates.
        # Assigns the given tile to the DungeonLebelCharacter.
        # Adds the DungeonLevelCharacterActor to the Stage.
        #
        # character_actor - The DungeonLevelCharacterActor to spawn.
        # tile_x    - The Tile's horizontal posititon.
        # tile_y    - The Tile's vertical posititon.
        #
        # Raises a RuntimeError if the DungeonLevelActor was not previously assigned to a Stage.
        # Returns true if the character was successfully spawned, false otherwise.
        def spawn_character!(character_actor, tile_x, tile_y)
          raise RuntimeError.new('Cannot spawn a character actor in a level without a stage') if get_stage.nil?

          if tile = dungeon_level.tile(tile_x, tile_y)
            character_actor.current_tile = tile
            add_actor(character_actor)
            @character_actors << character_actor
            get_stage.set_keyboard_focus(current_controlled_character)
            true
          else
            false
          end
        end

        # Public: Gives keyboard focus to the next Character in the list, and moves Camera to the Character.
        #
        # Returns nothing.
        def switch_control_to_next_playable_character!
          @controlled_character_index += 1
          @controlled_character_index = 0 if @controlled_character_index > (playable_characters.size - 1)
          get_stage.set_keyboard_focus(current_controlled_character)
          get_stage.screen.hud_stage.focus_character = current_controlled_character

          get_stage.get_camera.move_to!(
            current_controlled_character.screen_center_x_position,
            current_controlled_character.screen_center_y_position
          )
        end

        def new_turn!
          @character_actors.map(&:reset_for_new_turn!)
        end

        # Public: Get the current character that responds to input.
        #
        # Returns a DungeonLevelCharacter.
        def current_controlled_character
          playable_characters[@controlled_character_index]
        end

        # Public: Updates the DungeonLevelActor.
        # Overrides Actor#act.
        #
        # Returns nothing.
        def act(delta_time)
          get_stage.set_keyboard_focus(self) unless get_stage.get_keyboard_focus
          dungeon_level.tiles.each(&:apply_effects!)
          super
        end

        # Public: Draws the actor.
        # Overrides Actor#draw.
        #
        # Returns noting.
        def draw(sprite_batch, alpha)
          sprite_batch.end

          tiled_map_renderer.set_view(get_stage.camera)
          tiled_map_renderer.render

          sprite_batch.begin

          draw_character_actors(sprite_batch, alpha)
        end

        private

        def playable_characters
          @character_actors.select do |character_actor|
            (character_actor.team == player_team) and character_actor.playable?
          end
        end

        # Internal: Renders the Characters of the Level.
        #
        # Returns nothing.
        def draw_character_actors(sprite_batch, alpha)
          characters_by_drawing_order.each {|character_actor| character_actor.draw(sprite_batch, alpha) }
        end

        # Internal: Get the Characters in this Level, ordered by descending y_position.
        #
        # Returns an Array of Characaters.
        def characters_by_drawing_order
          @character_actors.sort_by {|character_actor| character_actor.y_position}.reverse
        end
      end
    end
  end
end
