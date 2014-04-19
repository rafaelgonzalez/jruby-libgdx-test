class YetAnotherDungeonCrawler < Game
  class DungeonCrawlScreen < ScreenAdapter

    attr_reader :hud_stage, :map_stage

    def show
      @map_stage = MapStage.new(self)
      @hud_stage = HudStage.new(self)

      input_multiplexer = InputMultiplexer.new
      input_multiplexer.add_processor(hud_stage)
      input_multiplexer.add_processor(map_stage.get_camera.input_processor)
      input_multiplexer.add_processor(map_stage)
      Gdx.input.set_input_processor(input_multiplexer)
    end

    def render
      map_stage.act(Gdx.graphics.get_delta_time)
      map_stage.draw

      hud_stage.act(Gdx.graphics.get_delta_time)
      hud_stage.draw
    end

    def resize(width, height)
      map_stage.viewport.update(width, height, true)
      hud_stage.viewport.update(width, height, true)
    end

    def dispose
      map_stage.dispose
      hud_stage.dispose
    end
  end
end

require_relative 'dungeon_crawl_screen/map_stage'
require_relative 'dungeon_crawl_screen/hud_stage'
