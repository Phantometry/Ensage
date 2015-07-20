--<<You touch my horn, I break your face! A script by Phantometry V1.2(a)>>
--[[
                                                               ▄                                                            
                                                            ╓█▀                                                             
  /\/\   __ _  __ _ _ __  _   _ ___                       ▄▓█▀                                                              
 /    \ / _` |/ _` | '_ \| | | / __|                    ▄▀ █`                                                               
/ /\/\ \ (_| | (_| | | | | |_| \__ \                  ,▓  █▌                                                                
\/    \/\__,_|\__, |_| |_|\__,_|___/                 ▄ ╒ █▌                                                                 
--------------|___/-----------------                ╬   ▐█                                                                  
                                                   ▄  ▌ █                                   ¢                               
   |_FEATURES_|                                   ▐  ▄ ▐▌                                 ╔▓                                
      - Auto ShockWave                            ▌ ┌▌ █                                ,▓╨                                 
      - Auto Skewer to base                      ▐  █  █                               ▄▀╨  f                               
      - Auto RP/Smart RP                         █ █   ▌                      ,▄▓▓Ñ╬▓█▀ ╩  Γ                                
        - With or without Skewer                .▌ █   ▌                    =███@   █▌ ▀  .▄▄╗,                             
                                                ▐ ▐    ▐                  ,▄▓,     ▄█▌    ▐▓▀▀▀▀▀▓▓▄,                       
   |_DESCRIPTION_|                              █ ▐    ╙╕                ,█▀`     ▐██▌,▐▄▄█▓░      ╙▀▓▄,                    
    AutoShockWave - Casts ShockWave on the     ▐█▄▄▌    ]                █▄▄█▓         "╙` ▀░         ╜▀▓▄                  
                    enemy closest to your        ▀ ╘     ▓              ▐▀▀▀▄▒     ╓▄Å@@╖               ╙▓▓▄                
                    mouseposition.                ▌ ╘     ▓                 ╘█`,▄▓▀"    "▀╖               ▒▓▓▄              
                                                   ▌       ▀▄               ┌▒▄▀"         █▌╖              ╙▀▒▌             
    AutoSkewer - Casts Blink then Skewer on the    ╘▄   5   ╙▌╦,            █▀   ,P▓"*    █▓▒▓~              ▒▓█,           
                 enemy closest to mouseposition     ▐,   ▀▄╓▀   ╙▄              ¿  ╛     ▐███▓▓Ç              ╙▓█▄          
                 towards your base.                  ▀ $  ▐▀      ▀        ╢  ,▓╦",* -  ╔ ▌  ▀█▓Ç              ╙▓█▄         
                                                      █ █▄▀       ▄▄,     ▄▄m' `▀▀ⁿ"   ▄╢╢█,   █▓,              ╙▓█▄        
    AutoRP - Casts Blink then RP on the target that   █░█N,     ╓▌   "▀▀▀▀╕`^        ▄╢▓▓▀   ,▄█▌               `▓█,       
             is closest to your mouseposition.          █▌ `N.  ╓▀╙N▄,   ╙╦,U        ███▀ ▄▄▀   ██@               ╙▓█       
           - If Skewer is toggled to true, then it      ▌   `W~█,   ╙▀Φ▄,  ▀▄         ,█` ▀    ███              ,=▓▓█      
             will also Skewer them back to the blink     ▀,   █▄  "5╖  `╜▀╖j `-   ╘▄▄██▌   ì  Æ ██▒        ,ç▄▓██▀▀▀█▌     
             position after casting RP.                      ▀Ä█╖"─    =,  ▐▌     , ██`  L  ▐█'  ▓]▓        j▓█       '     
                                                                  ▀Ä, ,  `░``▀     ██    ▐,F  ▄,╓   ▒   ç@▄@▄▓▓▓            
    SmartRP - Just like the regular AutoRP however this            '╩▄$▄`   └   ▄  \  ,▀▀,  ▐█    ║, ╟▓▀    ▀▀            
              actually casts to the centre of the enemies.               ▀▄      ▄  ,√▀L   ▐ ,╣`     ▓g▓▌                   
                                      (Credits to Nova)                    '╣  ▄█]╥╬▄, ▐▄▄▄@▀`     ╓' ▀█                    
            - Can set a minimum number on enemies you want to catch.         ▄╓▀ [               ,▀    `                    
                                                                                 [          ,,▄Ñ▀                           
    AutoSkewer, AutoRP and SmartRP require a Blink Dagger.                       ╘[╣   x╩▀`                                 
    The AutoRP combo's also make use of Refresher and Black King Bar.            ╚ ▌   
                                                                                    
                                                                                    
---------------------------------------------------------------------------------------------------------------------------------------------
      Changelog:- 
         -----Beta phase-----
            V0.1 Release was made, if there any bugs or suggestions, please notify me of them.
            
         -----Beta phase ended-----
            V1 Some small fixes were made. Script is now ready to be used.
         -----Release of version 1.1-----
            V1.1 A complete rework of AutoSkewer. Now it stops if opponent will dodge you. PLUS, the skewer is much more accurate right now.
                     Also there were some changes with backswing animations. The refresher combo is x2 faster than it was before. 
         -----Release of version 1.2-----
            V1.2 Some small fixes and additions were made. Now magnus move before an actual RP cast so it's even more faster and doesn't require him to waste around 1-2 seconds. 
                     In addition, some changes were made with sleepchecks so both manual and custom RP are more faster than before.
                        On top of that I need to say that magnus can move slightly off target after blinking in. I recommend you to try to face your enemy in order to perform the best 180 degrees turn.
                           I'd also recommend you to disable an auto attack after casting a spell option. It will make autoskewer even more accurate.
            V1.2(a) Toggle 100% RP option was added.
                                                                  
  P.S  Don't fuck with Rhino ]]

require("libs.Utils")
require("libs.ScriptConfig")
require("libs.SkillShot")
require("libs.Animations2")
require("libs.TargetFind")
require("libs.SmartCast")

config = ScriptConfig.new()
config:SetParameter("autorp", "D", config.TYPE_HOTKEY)
config:SetParameter("autoshoqwave","F",config.TYPE_HOTKEY)
config:SetParameter("autoskewer", "T", config.TYPE_HOTKEY)
config:SetParameter("customrp", "32", config.TYPE_HOTKEY)
config:SetParameter("toggleskewer", "G", config.TYPE_HOTKEY)
config:SetParameter("togglerp", "K", config.TYPE_HOTKEY)
config:SetParameter("customrptreshold", 3, config.TYPE_NUMBER)
config:Load()

local autorp = config.autorp
local autoshoqwave = config.autoshoqwave
local autoskewer = config.autoskewer
local customrp = config.customrp
local treshold = config.customrptreshold
local toggleskewer = config.toggleskewer
local autoskewer1 = false
local togglerp = config.togglerp
local togglerp1 = false
local step = 0
local center = 0
local active = false
local penis = false
local vagina = false
local automatic = false
local Distance = {}
local jesuschrist = 0

local x,y = 5, 55
local monitor = client.screenSize.x/1600
local ScreenX = client.screenSize.x
local ScreenY = client.screenSize.y
local Font = drawMgr:CreateFont("Font","Tahoma",0.02071875*ScreenY,0.4375*ScreenX)
local Font1 = drawMgr:CreateFont("Font","Tahoma",0.01671875*ScreenY,0.4375*ScreenX)
local statusText = drawMgr:CreateText(x*monitor,y*monitor,0x9CB7F7CC,"You touch my horn, I break your face! A script by Phantometry",Font) statusText.visible = false
local statusText2 = drawMgr:CreateText(x*monitor,(y+20)*monitor,0x3AE871A6,"For a manual rp-combo press "..string.char(autorp),Font1) statusText2.visible = false
local statusText3 = drawMgr:CreateText(x*monitor,(y+35)*monitor,0x3AE871A6,"To toggle skewer press "..string.char(toggleskewer),Font1) statusText3.visible = false
local statusText4 = drawMgr:CreateText(x*monitor,(y+50)*monitor,0x3AE871A6,"For an auto skewer press "..string.char(autoskewer),Font1) statusText4.visible = false
local statusText5 = drawMgr:CreateText(x*monitor,(y+65)*monitor,0x3AE871A6,"For smart rp hold Space",Font1) statusText5.visible = false
local statusText6 = drawMgr:CreateText(x*monitor,(y+80)*monitor,0x3AE871A6,"For an auto shockwave press "..string.char(autoshoqwave),Font1) statusText6.visible = false
local statusText7 = drawMgr:CreateText((x+1420)*monitor,(y)*monitor,0xF24949B3,"SkewerToggle: Off ",Font1) statusText7.visible = false
local statusText8 = drawMgr:CreateText(x*monitor,(y+110)*monitor,0x90FF4F73,"",Font1) statusText8.visible = false
local statusText9 = drawMgr:CreateText((x+1420)*monitor,(y+25)*monitor,0xF24949B3,"100% RP: Off ",Font1) statusText9.visible = false
local statusText10 = drawMgr:CreateText(x*monitor,(y+95)*monitor,0x3AE871A6,"For an 100% RP toggle press "..string.char(togglerp),Font1) statusText10.visible = false

function onLoad()
  if PlayingGame() then
    local me = entityList:GetMyHero()
    if me.classId ~= CDOTA_Unit_Hero_Magnataur then
      script:Disable()
    else
      registered = true
      script:RegisterEvent(EVENT_TICK,Main)
      script:RegisterEvent(EVENT_KEY,Key)
      script:UnregisterEvent(onLoad)
    end
  end
end

function Key(msg,code)
  if client.chat or client.console or client.loading then return end
  local me = entityList:GetMyHero()
  local dagger = me:FindItem("item_blink")


  if code == autoskewer then
    active = true
  end

  if IsKeyDown(string.byte("S")) then
    penis = false
    active = false
    vagina = false
  end

  if IsKeyDown(toggleskewer) then
    autoskewer1 = not autoskewer1
    if autoskewer1 == true then
      statusText7.text = "SkewerToggle: On"
      statusText7.color = 0x07E020B3
    else
      statusText7.text = "SkewerToggle: Off"
      statusText7.color = 0xF24949B3
    end
  end
  
    if IsKeyDown(togglerp) then
    togglerp1 = not togglerp1
    if togglerp1 == true then
      statusText9.text = "100% RP: On"
      statusText9.color = 0x07E020B3
    else
      statusText9.text = "100% RP: Off"
      statusText9.color = 0xF24949B3
    end
  end

  if dagger and code == autorp then
    penis = true
  end

  if code == autoshoqwave then
    vagina = (msg == KEY_DOWN)
  end
end



function Main(tick)
  if not SleepCheck() then return end
  local me = entityList:GetMyHero()
  if not me then return end

  local shoqwave = me:GetAbility(1)
  local skewer = me:GetAbility(3)
  local rp = me:GetAbility(4)
  local dagger = me:FindItem("item_blink")
  local refresher = me:FindItem("item_refresher")
  local bkb = me:FindItem("item_black_king_bar")

  target = targetFind:GetClosestToMouse(100)
  if target and active then
    if dagger and skewer:CanBeCasted() then
      local xyz = SkillShot.PredictedXYZ(target,me:GetTurnTime(target)*1000+630)
      if me:GetDistance2D(xyz) < 1125 then
        if me.team == 2 and SleepCheck("penischeck") then
          me:CastAbility(dagger,((xyz - me.position) * (75 + me:GetDistance2D(xyz)) / me:GetDistance2D(xyz) + me.position))
          me:CastAbility(skewer,Vector(-7149,-6696,383),true)
          Sleep(8000, "penischeck")
          Sleep(me:GetTurnTime(Vector(-7149,-6696,-383))*1000+300, "something")
        elseif SleepCheck("penischeck") then
          me:CastAbility(dagger,((xyz - me.position) * (75 + me:GetDistance2D(xyz)) / me:GetDistance2D(xyz) + me.position))
          me:CastAbility(skewer,Vector(7149,6696,383),true)
          Sleep(8000, "penischeck")
          Sleep(me:GetTurnTime(Vector(7149,6696,383))*1000+300, "something")
        end
      end
    end
    if SleepCheck("something") and dagger and dagger.cd > 0 and skewer:CanBeCasted() and not SleepCheck("penischeck") and GetDistance2D(me,target) > 125 then
      angle = me:FindRelativeAngle(target)
      if angle > 1.2 or angle < -1.3 then
        me:Stop()
        active = false
        Sleep(12000, "something")
      else
        active = false
      end
    elseif not skewer:CanBeCasted() or not dagger then
      active = false
    end
  end

  if target and vagina then
    local xyz = SkillShot.SkillShotXYZ(me,target,300,1050)
    if me:GetDistance2D(xyz) < 1100 then
      if shoqwave and shoqwave:CanBeCasted() then
        me:CastAbility(shoqwave,xyz)
        Sleep(1000)
      end
    end
  end

  if target and IsKeyDown(customrp) and not automatic and not client.chat then
    if rp and rp:CanBeCasted() then
      center = SmartCast.FindAOE(me:GetAbility(4), treshold, 380, 0, true)
      if center then
        step = 0
        penis = true
        automatic = true
      end
    end
  end


  if target and dagger and penis then
    if rp and rp:CanBeCasted() and step == 0 then
      if jesuschrist == 0 then
        daggerposition = me.position
      end
      if not automatic and me:GetDistance2D(target) < 1200 then
        me:CastAbility(dagger,target.position)
        me:Move(daggerposition, true)
      elseif
        automatic and center and me:GetDistance2D(center) < 1200 then
        me:CastAbility(dagger,center)
        me:Move(daggerposition, true)
        automatic = false
      else
        step = 0
        penis = false
        return
      end
      if jesuschrist == 0 then
        jesuschrist = 1
        Sleep(140)
        return
      end
      me:CastAbility(rp)
      step = 1
      jesuschrist = 0
      Sleep(500,"stun_delay")
      Sleep(800)
      return
    elseif step == 1 then
      if bkb then
        me:CastAbility(bkb)
      end
      if GetDistance2D(daggerposition,target.position) > GetDistance2D(daggerposition, me.position) then
        me:Move((target.position - daggerposition) * (100 + GetDistance2D(daggerposition,target))/ GetDistance2D(daggerposition,target) + daggerposition)
        if shoqwave:CanBeCasted() then
          me:CastAbility(shoqwave,target.position, true)
        end
      elseif me:CanCast() and shoqwave:CanBeCasted() then
        me:CastAbility(shoqwave,target.position)
      end
      step = 2

    elseif skewer and skewer:CanBeCasted() and step == 2 and SleepCheck("stun_delay") then
      if autoskewer1 then
        me:CastAbility(skewer,daggerposition)
      end
      if refresher then
        step = 3
        Sleep(3000,"refreshercheck")
        return
      else
        step = 0
        penis = false
      end
      Sleep(1000)
    elseif refresher and step == 3 and SleepCheck("refreshercheck") then
      me:CastAbility(refresher)
      step = 4
      Sleep(200,"anothercheck")
    elseif step == 4 and SleepCheck("anothercheck") and me:CanCast() then
      me:CastAbility(rp)
      step = 5
      Sleep(400,"blablabla")
    elseif step == 5 and SleepCheck("blablabla") and me:CanCast() then
      me:CastAbility(shoqwave,SkillShot.InFront(me,500), false)
      step = 0
      penis = false
      Sleep(1000)
      return
    end
  end


  if rp and togglerp1 and rp.abilityPhase then
    local enemies = entityList:GetEntities(function(v) return v.type == LuaEntity.TYPE_HERO and v.team == me:GetEnemyTeam() and v.visible and not v.illusion and v.alive and v:GetDistance2D(me) < 380  end)
    if #enemies == 0 then
      me:Stop()
    end
  end

  if ignore then
    return
  end

  if not expired then
    statusText.visible = true
    statusText2.visible = true
    statusText3.visible = true
    statusText4.visible = true
    statusText5.visible = true
    statusText6.visible = true
    statusText7.visible = true
    statusText8.visible = true
    statusText9.visible = true
    statusText10.visible = true
    
    timeremain = math.ceil(30 - client.gameTime)
    statusText8.text = "These messages will disappear in " .. (timeremain) .. " seconds"
    if timeremain < 1 then
      expired = true
    end
  elseif expired then
    statusText.visible = false
    statusText2.visible = false
    statusText3.visible = false
    statusText4.visible = false
    statusText5.visible = false
    statusText6.visible = false
    statusText8.visible = false
    statusText10.visible = false
    ignore = true
  end

end


function onClose()
  collectgarbage("collect")
  if registered then
    Text = {}
    script:UnregisterEvent(Main)
    script:UnregisterEvent(Key)
    script:RegisterEvent(EVENT_TICK,onLoad)
    registered = false
  end
end

script:RegisterEvent(EVENT_CLOSE,onClose)
script:RegisterEvent(EVENT_TICK,onLoad)
