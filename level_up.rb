# handles player level up and stat increases
module LevelUp

  # check if the player has levelled up and prompt for stat choice
  def self.check_level_up(player, hud)
    if player.just_levelled_up
      hud.add_message('level up! press S for strength or D for dexterity')
      player.just_levelled_up = false
      return true
    end
    return false
  end

  # increase strength on level up
  def self.increase_str(player, hud)
    player.str += 2
    hud.add_message('strength increased to ' + player.str.to_s + '!')
  end

  # increase dexterity on level up
  def self.increase_dex(player, hud)
    player.dex += 2
    hud.add_message('dexterity increased to ' + player.dex.to_s + '!')
  end

end