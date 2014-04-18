class DungeonCrawlInterface < Table

  attr_reader :character_details, :character_name, :health_bar, :stamina_bar, :mana_bar,
              :health_bar_label, :stamina_bar_label, :mana_bar_label

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

    @character_details = Table.new

    @character_name = Label.new('', skin)

    @health_bar = ProgressBar.new(0, 0, 1, false, skin)
    @health_bar_label = Label.new('', skin)

    @stamina_bar = ProgressBar.new(0, 0, 1, false, skin)
    @stamina_bar_label = Label.new('', skin)

    @mana_bar = ProgressBar.new(0, 0, 1, false, skin)
    @mana_bar_label = Label.new('', skin)

    character_details.add(character_name).colspan(2)

    character_details.row

    character_details.add(health_bar)
    character_details.add(health_bar_label)

    character_details.row

    character_details.add(stamina_bar)
    character_details.add(stamina_bar_label)

    character_details.row

    character_details.add(mana_bar)
    character_details.add(mana_bar_label)

    ### Layout setup

    self.add(top_messages).colspan(3).top.expand

    self.row

    self.add(combat_log).colspan(3).right.height(150).width(250).padRight(10).padBottom(10)
    self.row

    self.add(character_details).bottom.left.padLeft(10).padBottom(10).uniform
    self.add(skill_bar).expandX.bottom.padBottom(10)
    self.add(end_turn_button).bottom.right.padRight(10).padBottom(10).uniform
  end

  def set_character_details(character)
    character_name.set_text(character.name)

    health_bar.set_range(0, character.maximum_health)
    health_bar.set_value(character.health)

    stamina_bar.set_range(0, character.maximum_stamina)
    stamina_bar.set_value(character.stamina)

    mana_bar.set_range(0, character.maximum_mana)
    mana_bar.set_value(character.mana)
  end

  def draw(sprite_batch, alpha)
    super(sprite_batch, alpha)

    health_bar_label.set_text(" #{health_bar.get_value.to_i} / #{health_bar.get_max_value.to_i}")
    stamina_bar_label.set_text(" #{stamina_bar.get_value.to_i} / #{stamina_bar.get_max_value.to_i}")
    mana_bar_label.set_text(" #{mana_bar.get_value.to_i} / #{mana_bar.get_max_value.to_i}")
  end
end
