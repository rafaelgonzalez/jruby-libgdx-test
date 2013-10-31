require 'dungeon_crawl_stage'
require 'dungeon_level_actor'
require 'dungeon_level_character_actor'

class FooGame < Game
  include Input

  def create
    @dungeon_crawl_stage = DungeonCrawlStage.new

    # Instantiate dungeon level and add it to the stage
    dungeon_level = DungeonLevelActor.new
    @dungeon_crawl_stage.add_actor(dungeon_level)

    # Instantiate dungeon level characters and spawn them in the level
    dungeon_level.spawn_character!(DungeonLevelCharacterActor.new, 9, 1)
    dungeon_level.spawn_character!(DungeonLevelCharacterActor.new, 1, 1)
    dungeon_level.spawn_character!(DungeonLevelCharacterActor.new, 2, 7)

    # Try input on camera first, then on Stage
    input_multiplexer = InputMultiplexer.new
    input_multiplexer.add_processor(@dungeon_crawl_stage.camera.input_processor)
    input_multiplexer.add_processor(@dungeon_crawl_stage)
    Gdx.input.set_input_processor(input_multiplexer)

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)

    @dungeon_crawl_stage.act(Gdx.graphics.get_delta_time)
    @dungeon_crawl_stage.draw

    render_fps
  end

  def resize(width, height)
    @dungeon_crawl_stage.set_viewport(width, height, true)
  end

  def pause
  end

  def resume
  end

  def dispose
    @dungeon_crawl_stage.dispose
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