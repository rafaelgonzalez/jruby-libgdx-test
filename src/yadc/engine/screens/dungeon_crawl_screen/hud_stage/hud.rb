require_relative 'hud/character_details'
require_relative 'hud/end_turn_button'

module Yadc
  class Engine < Game
    class DungeonCrawlScreen < ScreenAdapter
      class HudStage < Stage
        class Hud < Table

          attr_reader :character_details, :end_turn_button, :top_message

          def initialize
            super

            skin = Skin.new(Gdx.files.internal('assets/libgdx-skin/uiskin.json'))

            self.set_fill_parent(true)

            ###

            @top_message = Label.new("Your turn", skin)

            ### Skill bar

            texture = Texture.new(Gdx.files.internal('assets/icons/W_Sword001.png'))
            sprite = Sprite.new(texture)
            sprite_drawable = SpriteDrawable.new(sprite)

            skill_bar = HorizontalGroup.new
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))
            skill_bar.add_actor(ImageButton.new(sprite_drawable))

            ####

            @end_turn_button = EndTurnButton.new(skin)

            ### Character details
            @character_details = CharacterDetails.new(skin)

            ### Layout setup

            self.add(top_message).colspan(2).top.expand

            self.row

            self.add(character_details.table).bottom.left.padLeft(10).padBottom(10).uniform
            # self.add(skill_bar).expandX.bottom.padBottom(10)
            self.add(end_turn_button.button).bottom.right.padRight(10).padBottom(10).uniform
          end
        end
      end
    end
  end
end
