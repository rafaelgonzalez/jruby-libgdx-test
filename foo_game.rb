class FooGame < Game
  include Input

  SPRITE_WIDTH = 64
  SPRITE_HEIGHT = 64

  def create
    animation_sheet = Texture.new(Gdx.files.internal("data/light.png"))
    walk_frames = TextureRegion.split(animation_sheet, SPRITE_WIDTH, SPRITE_HEIGHT)[11][0..8]

    @walk_animation = Animation.new(0.15, walk_frames)
    @sprite_batch = SpriteBatch.new
    @state_time = 0.0
  end

  def render
    Gdx.app.exit if is_key_pressed?(Keys::ESCAPE)

    Gdx.gl.glClear(GL10::GL_COLOR_BUFFER_BIT | GL10::GL_DEPTH_BUFFER_BIT)
    @state_time = @state_time + Gdx.graphics.get_delta_time
    current_frame = @walk_animation.get_key_frame(@state_time, true)

    sprite_x_pos = (Gdx.graphics.get_width / 2) - (SPRITE_WIDTH / 2)
    sprite_y_pos = (Gdx.graphics.get_height / 2) - (SPRITE_HEIGHT / 2) 

    @sprite_batch.begin
    @sprite_batch.draw(current_frame, sprite_x_pos, sprite_y_pos)
    @sprite_batch.end
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