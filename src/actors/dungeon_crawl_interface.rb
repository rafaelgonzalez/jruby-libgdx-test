class DungeonCrawlInterface < Table

  attr_reader :character_details

  def initialize
    super

    skin = Skin.new(Gdx.files.internal('assets/libgdx-skin/uiskin.json'))

    self.set_fill_parent(true)

    ###

    top_messages = Label.new("Your turn", skin)

    combat_log = Dialog.new("Combat log", skin)

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

    end_turn_button = TextButton.new('END TURN', skin)

    ### Character details
    @character_details = CharacterDetails.new(skin)

    ### Layout setup

    self.add(top_messages).colspan(3).top.expand

    self.row

    self.add(combat_log).colspan(3).right.height(150).width(250).padRight(10).padBottom(10)
    self.row

    self.add(character_details.table).bottom.left.padLeft(10).padBottom(10).uniform
    self.add(skill_bar).expandX.bottom.padBottom(10)
    self.add(end_turn_button).bottom.right.padRight(10).padBottom(10).uniform
  end
end

require_relative 'dungeon_crawl_interface/character_details'
