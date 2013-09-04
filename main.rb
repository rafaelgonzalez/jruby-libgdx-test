require 'java'
require 'lib/gdx-backend-lwjgl-natives.jar'
require 'lib/gdx-backend-lwjgl.jar'
require 'lib/gdx-natives.jar'
require 'lib/gdx.jar'

java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.graphics.GL10
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.BitmapFont

java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration

require 'foo_game'

cfg = LwjglApplicationConfiguration.new
cfg.title = "FooGame"
cfg.useGL20 = true
cfg.width = 800
cfg.height = 640
LwjglApplication.new(FooGame.new, cfg)