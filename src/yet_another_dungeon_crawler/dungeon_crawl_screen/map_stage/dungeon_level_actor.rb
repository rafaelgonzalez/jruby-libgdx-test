class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter
    class MapStage < Stage
      class DungeonLevelActor < Group
        TILE_WIDTH = 32
        TILE_HEIGHT = 32

        attr_reader :dungeon_level, :tiled_map_renderer, :character_actors

        def initialize(dungeon_level, tiled_map)
          super()

          set_name 'Level characters'

          @dungeon_level = dungeon_level

          @tiled_map_renderer = OrthogonalTiledMapRenderer.new(tiled_map)

          @character_actors = []
          create_actors
        end

        # Public: Updates the DungeonLevelActor.
        # Overrides Actor#act.
        #
        # Returns nothing.
        def act(delta_time)
          create_actors
          super
        end

        # Public: Draws the actor.
        # Overrides Actor#draw.
        #
        # Returns noting.
        def draw(sprite_batch, alpha)
          sprite_batch.end

          tiled_map_renderer.set_view(get_stage.camera)
          tiled_map_renderer.render(map_layers_below_characters)

          sprite_batch.begin

          draw_character_actors(sprite_batch, alpha)

          sprite_batch.end

          tiled_map_renderer.render(map_layers_above_characters)

          sprite_batch.begin
        end

        private

        def create_actors
          dungeon_level.characters.each do |character|
            create_actor(character) unless character.actor
          end
        end

        def create_actor(character)
          character.actor = DungeonLevelCharacterActor.new(character)
          add_actor(character.actor)
          character_actors.push(character.actor)
          character.actor.set_x(character.actor.screen_x_position)
          character.actor.set_y(character.actor.screen_y_position)
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
          character_actors.sort_by {|character_actor| character_actor.y_position}.reverse
        end

        def map_layers_below_characters
          layers = []

          tiled_map_renderer.map.get_layers.each_with_index do |layer, index|
            unless layer.get_properties.get('render') == 'hover'
              layers.push index
            end
          end

          layers.to_java(:int)
        end

        def map_layers_above_characters
          layers = []

          tiled_map_renderer.map.get_layers.each_with_index do |layer, index|
            if layer.get_properties.get('render') == 'hover'
              layers.push index
            end
          end

          layers.to_java(:int)
        end
      end
    end
  end
end
