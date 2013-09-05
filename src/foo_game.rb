class FooGame < Game
  include Input

  def create
    @character_renderer = CharacterRenderer.new
    @state_time = 0.0
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)
    @state_time = @state_time + Gdx.graphics.get_delta_time

    sprite_x_pos = (Gdx.graphics.get_width / 2) - (CharacterRenderer::SPRITE_WIDTH / 2)
    sprite_y_pos = (Gdx.graphics.get_height / 2) - (CharacterRenderer::SPRITE_HEIGHT / 2)

    @character_renderer.draw(@state_time, sprite_x_pos, sprite_y_pos)
  end

  def resize(width, height)
  end

  def pause
  end

  def resume
  end

  def dispose
  end


  private

  def is_key_pressed?(key)
    Gdx.input.is_key_pressed(key)
  end
end