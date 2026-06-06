# handles all of the keyboard input.
require_relative 'combat'
require_relative 'character'
require_relative 'level_up'

module InputHandler

  # remove dead npcs from the array but keep the dummy
  def self.remove_dead_npcs(npcs)
    i = 0
    while i < npcs.length
      if Combat.dead?(npcs[i]) && npcs[i].type != 'dummy'
        npcs.delete_at(i)
      else
        i += 1
      end
    end
  end

  def self.handle(id, player, npcs, map, hud, level_up_pending, player_attack_sound, enemy_attack_sound)

    # if a level up is on screen only accept s or d keypress
    if level_up_pending
      if id == Gosu::KB_S
        LevelUp.increase_str(player, hud)
        return false
      elsif id == Gosu::KB_D
        LevelUp.increase_dex(player, hud)
        return false
      end
      return true
    end

    # if the player presses right, face right
    if id == Gosu::KB_RIGHT
      player.face_right

      # check if enemy is on the target tile and if so perform attack
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x + 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        # play the player attack sound
        player_attack_sound.play

        # add the result of the attack to the event log
        hud.add_message(hud.combat_message(npc, result))

        # give xp for every hit on the dummy, or only on kill for regular enemies
        if npc.type == 'dummy'
          if result == 'hit' or result == 'partial'
            player.gain_xp(npc.xp_value)
          end
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        

        # remove any enemies that have been killed
        remove_dead_npcs(npcs)

      # if no enemy check if the tile is passable and move the player
      elsif map.detect_collision(player.x + 1, player.y)

        # any adjacent enemies get a free hit before the player moves away
        Combat.opportunity_attacks(player, npcs, hud, enemy_attack_sound)
        player.move_right
      end

      # give each npc their turn to move or attack
      i = 0
      while i < npcs.length
        result = npcs[i].move_toward(player, map, npcs)
        if result == 'hit' or result == 'partial' or result == 'miss'
          hud.add_message(hud.npc_attack_message(npcs[i], result))
          enemy_attack_sound.play
        end
        i += 1
      end

    # same as above for left
    elsif id == Gosu::KB_LEFT
      player.face_left
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x - 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        player_attack_sound.play
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == 'dummy'
          if result == 'hit' or result == 'partial'
            player.gain_xp(npc.xp_value)
          end
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        remove_dead_npcs(npcs)
      elsif map.detect_collision(player.x - 1, player.y)
        Combat.opportunity_attacks(player, npcs, hud, enemy_attack_sound)
        player.move_left
      end
      i = 0
      while i < npcs.length
        result = npcs[i].move_toward(player, map, npcs)
        if result == 'hit' or result == 'partial' or result == 'miss'
          hud.add_message(hud.npc_attack_message(npcs[i], result))
          enemy_attack_sound.play
        end
        i += 1
      end


    # same as above for up
    elsif id == Gosu::KB_UP
      player.face_up
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y - 1)
      if npc
        result = Combat.perform_attack(player, npc)
        player_attack_sound.play
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == 'dummy'
          if result == 'hit' or result == 'partial'
            player.gain_xp(npc.xp_value)
          end
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        remove_dead_npcs(npcs)
      elsif map.detect_collision(player.x, player.y - 1)
        Combat.opportunity_attacks(player, npcs, hud, enemy_attack_sound)
        player.move_up
      end
      i = 0
      while i < npcs.length
        result = npcs[i].move_toward(player, map, npcs)
        if result == 'hit' or result == 'partial' or result == 'miss'
          hud.add_message(hud.npc_attack_message(npcs[i], result))
          enemy_attack_sound.play
        end
        i += 1
      end

    # same as above for down
    elsif id == Gosu::KB_DOWN
      player.face_down
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y + 1)
      if npc
        result = Combat.perform_attack(player, npc)
        player_attack_sound.play
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == 'dummy'
          if result == 'hit' or result == 'partial'
            player.gain_xp(npc.xp_value)
          end
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
         remove_dead_npcs(npcs)
      elsif map.detect_collision(player.x, player.y + 1)
        Combat.opportunity_attacks(player, npcs, hud, enemy_attack_sound)
        player.move_down
      end
      i = 0
      while i < npcs.length
        result = npcs[i].move_toward(player, map, npcs)
        if result == 'hit' or result == 'partial' or result == 'miss'
          hud.add_message(hud.npc_attack_message(npcs[i], result))
          enemy_attack_sound.play
        end
        i += 1
      end
    end

    # check if player leveled up after any action
    if LevelUp.check_level_up(player, hud)
      return true
    end

    return false
  end

end