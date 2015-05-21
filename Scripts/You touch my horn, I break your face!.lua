--<<You touch my horn, I break your face! A script by Phantometry V0.1>>
--[[ 
      Description:-
           An ultimate combos for Magnus.
               Includes usage of items:
                   - Black King Bar
                   - Refresher's Orb
                   Required items:
                      - Blink Dagger

      Changelog:- 
         -----Beta phase--
            V0.1 Release was made, if there any bugs or suggestions, please notify me of them.
            
            
                                                                                       ,'   `---.___.---'  `.
                                                                                   ,'   ,-                 `-._
                                                                                   ,'    /                       \
                                                                                ,\/     /                        \\
                                                                            )`._)>)     |                         \\
                                                                          `>,'    _   \                  /       ||
                                                                              )      \   |   |            |        |\\
                                                                     .   ,   /        \  |    `.          |        | ))
                                                                     \`. \`-'          )-|      `.        |        /((
                                                                      \ `-`   .`     _/  \ _     )`-.___.--\      /  `'
                                                                       `._         ,'     `j`.__/           `.    \
                                                                         / ,    ,'         \   /`             \   /
                                                                         \__   /           _) (               _) (
                                                                           `--'           /____\             /____\
                                                   
  P.S  Don't fuck with rhyno ]]
     
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
config:SetParameter("customrptreshold", 3, config.TYPE_NUMBER)
config:Load()

local autorp = config.autorp
local autoshoqwave = config.autoshoqwave
local autoskewer = config.autoskewer
local customrp = config.customrp
local treshold = config.customrptreshold
local toggleskewer = config.toggleskewer
local autoskewer1 = false
local step = 0
local center = 0
local active = false
local penis = false
local vagina = false
local automatic = false
local Distance = {}

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
local statusText5 = drawMgr:CreateText(x*monitor,(y+65)*monitor,0x3AE871A6,"For smart rp press Space",Font1) statusText5.visible = false
local statusText6 = drawMgr:CreateText(x*monitor,(y+80)*monitor,0x3AE871A6,"For an auto shockwave press "..string.char(autoshoqwave),Font1) statusText6.visible = false
local statusText7 = drawMgr:CreateText((x+1420)*monitor,(y)*monitor,0xF24949B3,"SkewerToggle: Off ",Font1) statusText7.visible = false
local statusText8 = drawMgr:CreateText(x*monitor,(y+95)*monitor,0x90FF4F73,"",Font1) statusText8.visible = false

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

  if code == autoskewer then
    active = (msg == KEY_DOWN)
  end

  if IsKeyDown(string.byte("S")) then
    penis = false
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

  if code == autorp then
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
      local xyz = SkillShot.PredictedXYZ(target,me:GetTurnTime(target)*1000+400)
      if me:GetDistance2D(xyz) < 1200 then
        if me.team == 2 then
          me:CastAbility(dagger,xyz)
          me:CastAbility(skewer,Vector(-7149,-6696,383),true)
          Sleep(8000)
        else
          me:CastAbility(dagger,xyz)
          me:CastAbility(skewer,Vector(7149,6696,383),true)
          Sleep(8000)
        end
      end
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


  if target and penis then
    if rp and rp:CanBeCasted() and step == 0 then
      daggerposition = me.position
      if not automatic and me:GetDistance2D(target) < 1200 then
        me:CastAbility(dagger,target.position)
      elseif
        automatic and center and me:GetDistance2D(center) < 1200 then
        me:CastAbility(dagger,center)
        automatic = false
      else
       step = 0
       penis = false
      return
      end
      me:CastAbility(rp)
      step = 1
      Sleep(3000,"stun_delay")
      Sleep(800)
      return
    elseif step == 1 then
      if bkb then
        me:CastAbility(bkb)
      end
      me:Move((target.position - daggerposition) * (100 + GetDistance2D(daggerposition,target))/ GetDistance2D(daggerposition,target) + daggerposition)
      me:CastAbility(shoqwave,target.position, true)
      step = 2

    elseif skewer and skewer:CanBeCasted() and step == 2 and SleepCheck("stun_delay") then
      if autoskewer1 then
        me:CastAbility(skewer,daggerposition)
      end
      if refresher then
        step = 3
        Sleep(800,"refreshercheck")
        return
      else
        step = 0
        penis = false
      end
      Sleep(1000)
    elseif refresher and step == 3 and SleepCheck("refreshercheck") then
      me:CastAbility(refresher)
      me:CastAbility(rp)
      me:CastAbility(shoqwave,SkillShot.InFront(me,500), true)
      step = 4
      Sleep(800,"anothercheck")
    elseif step == 4 and SleepCheck("anothercheck") then
      me:CastAbility(rp)
      me:CastAbility(shoqwave,SkillShot.InFront(me,500), true)
      step = 0
      penis = false
      Sleep(1000)
      return
    end
  end


  if rp and rp.abilityPhase then
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
