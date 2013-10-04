class Dungeon
  class Level

    TILE_WIDTH = 32
    TILE_HEIGHT = 32

    attr_reader :tile_width, :tile_height, :level_characters

    def initialize
      @tiled_map = TmxMapLoader.new.load("assets/maps/level_1.tmx")
      @tiled_map_renderer = OrthogonalTiledMapRenderer.new(@tiled_map)

      @level_characters = []
    end

    def spawn_character!(character, x_position, y_position)
      @level_characters.push Character.new(character, x_position, y_position)
    end

    def draw(state_time, camera)
      @tiled_map_renderer.set_view(camera)
      @tiled_map_renderer.render
      @level_characters.each {|character| character.render(state_time, camera) }
    end
  end
end