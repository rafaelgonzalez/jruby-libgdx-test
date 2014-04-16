require 'java'
require 'lib/java/libgdx-nightly-20140413/gdx-backend-lwjgl-natives.jar'
require 'lib/java/libgdx-nightly-20140413/gdx-backend-lwjgl.jar'
require 'lib/java/libgdx-nightly-20140413/gdx-natives.jar'
require 'lib/java/libgdx-nightly-20140413/gdx.jar'

java_import com.badlogic.gdx.ApplicationListener
java_import com.badlogic.gdx.Game
java_import com.badlogic.gdx.Gdx
java_import com.badlogic.gdx.Input
java_import com.badlogic.gdx.InputAdapter
java_import com.badlogic.gdx.InputMultiplexer
java_import com.badlogic.gdx.graphics.GL20
java_import com.badlogic.gdx.graphics.Texture
java_import com.badlogic.gdx.graphics.OrthographicCamera
java_import com.badlogic.gdx.graphics.g2d.Animation
java_import com.badlogic.gdx.graphics.g2d.BitmapFont
java_import com.badlogic.gdx.graphics.g2d.Sprite
java_import com.badlogic.gdx.graphics.g2d.SpriteBatch
java_import com.badlogic.gdx.graphics.g2d.TextureRegion

java_import com.badlogic.gdx.math.Vector3

java_import com.badlogic.gdx.scenes.scene2d.Actor
java_import com.badlogic.gdx.scenes.scene2d.Group
java_import com.badlogic.gdx.scenes.scene2d.InputListener
java_import com.badlogic.gdx.scenes.scene2d.Stage

java_import com.badlogic.gdx.scenes.scene2d.actions.Actions
java_import com.badlogic.gdx.scenes.scene2d.actions.MoveToAction
java_import com.badlogic.gdx.scenes.scene2d.actions.RunnableAction

java_import com.badlogic.gdx.scenes.scene2d.ui.Dialog
java_import com.badlogic.gdx.scenes.scene2d.ui.HorizontalGroup
java_import com.badlogic.gdx.scenes.scene2d.ui.ImageButton
java_import com.badlogic.gdx.scenes.scene2d.ui.Label
java_import com.badlogic.gdx.scenes.scene2d.ui.ProgressBar
java_import com.badlogic.gdx.scenes.scene2d.ui.Skin
java_import com.badlogic.gdx.scenes.scene2d.ui.Table
java_import com.badlogic.gdx.scenes.scene2d.ui.TextButton
java_import com.badlogic.gdx.scenes.scene2d.ui.VerticalGroup
java_import com.badlogic.gdx.scenes.scene2d.utils.SpriteDrawable

java_import com.badlogic.gdx.maps.tiled.TmxMapLoader
java_import com.badlogic.gdx.maps.tiled.renderers.OrthogonalTiledMapRenderer

java_import com.badlogic.gdx.backends.lwjgl.LwjglApplication
java_import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration
