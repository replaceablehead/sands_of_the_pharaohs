# handles all of the keyboard input.
require_relative 'combat'
require_relative 'character'
require_relative 'level_up'

module InputHandler

  def self.handle(id, player, npcs, map, hud, level_up_pending)
    # if a level up is pending only accept s or d keypress
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

    if id == Gosu::KB_RIGHT
      player.face_right
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x + 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == :dummy
          player.gain_xp(npc.xp_value) if result == :hit or result == :partial
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        npcs.reject! { |n| Combat.dead?(n) && n.type != :dummy }
      elsif map.detect_collision(player.x + 1, player.y)
        player.move_right
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_LEFT
      player.face_left
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x - 1, player.y)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == :dummy
          player.gain_xp(npc.xp_value) if result == :hit or result == :partial
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        npcs.reject! { |n| Combat.dead?(n) && n.type != :dummy }
      elsif map.detect_collision(player.x - 1, player.y)
        player.move_left
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_UP
      player.face_up
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y - 1)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == :dummy
          player.gain_xp(npc.xp_value) if result == :hit or result == :partial
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        npcs.reject! { |n| Combat.dead?(n) && n.type != :dummy }
      elsif map.detect_collision(player.x, player.y - 1)
        player.move_up
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    elsif id == Gosu::KB_DOWN
      player.face_down
      npc = Combat.check_for_enemy_on_target_tile(npcs, player.x, player.y + 1)
      if npc
        result = Combat.perform_attack(player, npc)
        hud.add_message(hud.combat_message(npc, result))
        if npc.type == :dummy
          player.gain_xp(npc.xp_value) if result == :hit or result == :partial
        elsif Combat.dead?(npc)
          player.gain_xp(npc.xp_value)
        end
        npcs.reject! { |n| Combat.dead?(n) && n.type != :dummy }
      elsif map.detect_collision(player.x, player.y + 1)
        player.move_down
      end
      npcs.each do |npc|
        result = npc.move_toward(player, map, npcs)
        if result == :hit or result == :partial or result == :miss
          hud.add_message(hud.npc_attack_message(npc, result))
        end
      end
    end

    # check if player levelled up after any action
    if LevelUp.check_level_up(player, hud)
      return true
    end

    return false
  end

end