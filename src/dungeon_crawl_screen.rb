require 'dungeon_crawl_map_stage'
require 'dungeon_crawl_hud_stage'

class DungeonCrawlScreen < ScreenAdapter

  attr_reader :hud_stage, :map_stage

  def show
    @map_stage = DungeonCrawlMapStage.new
    @hud_stage = DungeonCrawlHudStage.new(map_stage)

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
