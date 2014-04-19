require 'dungeon_crawl_screen'

class YetAnotherDungeonCrawler < Game
  include Input

  def create
    self.set_screen(DungeonCrawlScreen.new)

    @font = BitmapFont.new
    @screen_text = SpriteBatch.new
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL20::GL_COLOR_BUFFER_BIT | GL20::GL_DEPTH_BUFFER_BIT)

    get_screen.render

    render_fps
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
