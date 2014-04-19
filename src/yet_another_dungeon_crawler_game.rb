require 'dungeon_crawl_map_stage'
require 'dungeon_crawl_hud_stage'

class YetAnotherDungeonCrawler < Game
  include Input

  attr_reader :hud_stage, :map_stage

  def create
    @map_stage = DungeonCrawlMapStage.new
    @hud_stage = DungeonCrawlHudStage.new(map_stage)

    input_multiplexer = InputMultiplexer.new
    input_multiplexer.add_processor(hud_stage)
    input_multiplexer.add_processor(map_stage.get_camera.input_processor)
    input_multiplexer.add_processor(map_stage)
    Gdx.input.set_input_processor(input_multiplexer)

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)

    map_stage.act(Gdx.graphics.get_delta_time)
    map_stage.draw

    hud_stage.act(Gdx.graphics.get_delta_time)
    hud_stage.draw

    render_fps
  end

  def resize(width, height)
    map_stage.viewport.update(width, height, true)
    hud_stage.viewport.update(width, height, true)
  end

  def pause
  end

  def resume
  end

  def dispose
    map_stage.dispose
    hud_stage.dispose
  end


  private

  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end

  def render_fps
    @screen_text.begin
    @font.draw(@screen_text, "#{Gdx.graphics.get_frames_per_second} FPS", 10, Gdx.graphics.get_height - 10)
    @screen_text.end
  end
end
