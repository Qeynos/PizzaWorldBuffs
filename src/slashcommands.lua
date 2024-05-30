local PWB = PizzaWorldBuffs

SLASH_PIZZAWORLDBUFFS1, SLASH_PIZZAWORLDBUFFS2, SLASH_PIZZAWORLDBUFFS3 = '/wb', '/pwb', '/pizzawb'

SlashCmdList['PIZZAWORLDBUFFS'] = function (args, editbox)
  local cmd, msg = PWB.utils.strSplit(args, ' ')
  local command = cmd and string.lower(cmd)

  if command == 'show' then
    PWB_config.show = true
    PWB.frame:Show()
    return
  end

  if command == 'hide' then
    PWB_config.show = false
    PWB.frame:Hide()
    return
  end

  if command == 'clear' then
    PWB.core.clearAllTimers()
    return
  end

  if command == 'fontsize' then
    local fontSize = tonumber(msg)
    if not fontSize then
      PWB:Print('无效选项，只允许使用数字！')
      return
    end

    PWB_config.fontSize = fontSize
    PWB.frame.updateFrames()
    PWB:Print('已将字体大小更改为 ' .. PWB_config.fontSize)
    return
  end

  if command == 'align' then
    local align = string.lower(msg)
    if align ~= 'left' and align ~= 'center' and align ~= 'right' then
      PWB:Print('无效选项，有效选项为：left, center, right')
      return
    end

    PWB_config.align = align
    PWB.frame.updateFrames()
    PWB:Print('已将文本对齐方式更改为 ' .. PWB_config.align)
    return
  end

  if command == 'all' then
    local number = tonumber(msg)
    if not number or (number ~= 0 and number ~= 1) then
      PWB:Print('有效选项为 0 和 1')
      return
    end

    PWB_config.allFactions = number == 1
    local message = '显示 ' .. (PWB_config.allFactions and '双方' or '仅您的') .. ' 阵营的世界增益计时器'
    PWB:Print(message)
    return
  end

  if command == 'sharing' then
    local number = tonumber(msg)
    if not number or (number ~= 0 and number ~= 1) then
      PWB:Print('有效选项为 0 和 1')
      return
    end

    PWB_config.sharingEnabled = number == 1

    -- If sharing was disabled, clear all timers we didn't witness ourselves
    if not PWB_config.sharingEnabled then
      PWB.utils.forEachTimer(function (timer)
        if timer.witness ~= PWB.me then
          PWB.core.clearTimer(timer)
        end
      end)
    end

    local suffix = PWB_config.sharingEnabled and ' 已启用，您将看到其他玩家的计时器。' or ' 已禁用，您只会看到您自己的计时器。'
    local message = '您和其他玩家之间的计时器共享' .. suffix
    PWB:Print(message)

    return
  end

  if command == 'logout' then
    local number = tonumber(msg)
    if not number or (number ~= 0 and number ~= 1) then
      PWB:Print('有效选项为 0 和 1')
      return
    end

    PWB_config.autoLogout = number == 1

    PWB.frame.updatePizzaWorldBuffsHeader()
    local suffix = PWB_config.autoLogout and ' 已启用，您下次重新登录或重新加载UI时将会自动禁用。' or ' 已禁用。'
    PWB:Print('接收下一个增益后自动登出' .. suffix)
    return
  end

  if command == 'setquit' then
    local number = tonumber(msg)
    if not number or (number ~= 0 and number ~= 1) then
      PWB:Print('有效选项为 0 和 1')
      return
    end

    PWB_config.setQuit = number == 1

    PWB.frame.updatePizzaWorldBuffsHeader()
    local suffix = PWB_config.setQuit and ' 已启用。' or ' 已禁用。'
    PWB:Print('使用退出游戏代替登出' .. suffix)
    return
  end
  
  if command == 'version' then
    PWB:Print('版本 ' .. PWB.utils.getVersion())
    return
  end

  PWB:PrintClean(PWB.Colors.primary .. 'Pizza' .. PWB.Colors.secondary .. 'WorldBuffs|r commands:')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r show ' .. PWB.Colors.grey .. '- 显示插件')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r hide ' .. PWB.Colors.grey .. '- 隐藏插件')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r all ' .. (PWB_config.allFactions and 1 or 0) .. PWB.Colors.grey .. ' - 显示所有阵营的世界增益计时器')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r sharing ' .. (PWB_config.sharingEnabled and 1 or 0) .. PWB.Colors.grey .. ' - 启用你和其他玩家之间的计时器共享')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r logout ' .. (PWB_config.autoLogout and 1 or 0) .. PWB.Colors.grey .. ' - 接收下一个增益后自动登出')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r setquit ' .. (PWB_config.setQuit and 1 or 0) .. PWB.Colors.grey .. ' - 使用退出游戏代替登出')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r clear ' .. PWB.Colors.grey .. '- 清除所有世界增益计时器')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r fontsize ' .. PWB_config.fontSize .. PWB.Colors.grey .. ' - 设置字体大小')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r align ' .. PWB_config.align .. PWB.Colors.grey .. ' - 对齐文本 左/中/右')
  PWB:PrintClean(PWB.Colors.primary .. '   /wb|r version ' .. PWB.Colors.grey .. '- 显示当前版本')
end
