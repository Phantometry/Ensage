--<<Lina FK DA POLICE by Phantometry and Nova-chan V1.3>>-
--[[
 
    Description:-
             This will cast a perfect Eul's combo on the target while holding the hotkey.
                 Includes usage of items -
                       - Ethereal Blade
                           - Dagon
 
    ChangeLog:-
       ----- Beta Phase -----
           V0.1b - Script made, there will be bugs, please notify me of them
           V0.2b - Text Added, Combo timings improved
           ----- Beta Phase Ended -----
           V1 - Change to Combo to avoid multiple casting.
                - Improved damage calculation to even include Health Regen, it's accurate to about  + 1 or 2 instances of regen. Even at high regen rates.
                            - PLUS 1 or 2 so it will always kill if it says it can kill. And target is never left with say 1 or 2 health.
                            - Included an exception for heart.
                        - Improved combo to be a lot more efficient and take ping into consideration
                        - Created an initial startup message (Using Nova's Earth Spirit Script)
                       
                        - Changed text location so it works for many monitor sizes.
                        - Added an option to toggle the text if you feel it gives you FPS problems.
                            - Added a hotkey to toggle the text.
                               
                        - Various changes to improve FPS
                        
	   ----- Update -----   
	   V1.1 - Change to cancel the backswing animation of the Q to allow a faster combo, and also a small fix that should fix the problems people were having.
	   
	   ----- Update -----
	   V1.2 - An UltimateToggle option was added.
	   
	   ----- Update -----
	   V1.3 - Fixed for patch 6.84.
			
            Credits:-
                     Nova-chan - Without him I would've never been able to make any of this. He always helps me whenever I need it.
                                                He has taught me everything I know and also given me permission to use any of his code in my scripts.
                                                                       
                Closing Remarks -
                    Lastly, if you have any requests then please don't hesistate to post them on the thread.
 
]]

require("libs.Utils")
require("libs.ScriptConfig")
require("libs.TargetFind")
require("libs.Animations")

config = ScriptConfig.new()
config:SetParameter("ComboKey", "D", config.TYPE_HOTKEY)
config:SetParameter("TextToggle", "P", config.TYPE_HOTKEY)
config:SetParameter("UltimateToggle", "K", config.TYPE_HOTKEY)
config:Load()

local comboKey = config.ComboKey
local UltimateToggle = config.UltimateToggle
local UltimateActive = true
local TextToggle = config.TextToggle
local ShowText = true
local registered = false
local target = nil
local active = false
local delay = 0
local Text = {}
local Order = 0
local inCombo = false
local expired = false

local x,y = 5, 55
local monitor = client.screenSize.x/1600
local F14 = drawMgr:CreateFont("F14","Segoe UI",14,500)
local F15 = drawMgr:CreateFont("F15","Segoe UI",18,580)
local statusText = drawMgr:CreateText(x*monitor,y*monitor,0xE35B00FF,"Lina - FK DA POLICE!",F15) statusText.visible = false
local statusText2 = drawMgr:CreateText(x*monitor,(y+20)*monitor,0xF7E559FF,"For this script you require Euls, Combo Key is "..string.char(comboKey).." - HOLD",F14) statusText2.visible = false
local statusText3 = drawMgr:CreateText(x*monitor,(y+35)*monitor,0xF7E559FF,"To toggle the text above enemies, press "..string.char(TextToggle),F14) statusText3.visible = false
local statusText4 = drawMgr:CreateText(x*monitor,(y+65)*monitor,-1,"",F14) statusText4.visible = false
local statusText5 = drawMgr:CreateText(x*monitor,(y+50)*monitor,0xF7E559FF,"To toggle your ultimate press "..string.char(UltimateToggle),F14) statusText5.visible = false

function Key(msg,code)
  if client.chat or client.console or client.loading then return end
  if code == comboKey then
    active = (msg == KEY_DOWN)
  end
  if IsKeyDown(TextToggle) then
    ShowText = not ShowText
  end
  if IsKeyDown(UltimateToggle) then
    UltimateActive = not UltimateActive
  end
end

function Main(tick)
  if not SleepCheck() then return end
  local me = entityList:GetMyHero()
  if not me then return end

  local Eul = me:FindItem("item_cyclone")
  local Ethereal = me:FindItem("item_ethereal_blade")
  local Q = me:GetAbility(1)
  local W = me:GetAbility(2)
  local R = me:GetAbility(4)
  local dagon = me:FindDagon()

  if ShowText and SleepCheck("Drop") then
    local Enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,illusion=false,team=me:GetEnemyTeam()})
    for i,v in ipairs(Enemies) do
      local OnScreen = client:ScreenPosition(v.position)
      Damage = DamageCalculation(v)
      REGEN = GetHealthRegen(v)
      if OnScreen then
        if v.healthbarOffset ~= -1 then
          if not Text[v.handle] then
            Font = drawMgr:CreateFont("F14","Segoe UI",14,550)
            Text[v.handle] = drawMgr:CreateText(-60*monitor,-55*monitor, 0x00FFFFAA, "HP to Kill: ",Font)
            Text[v.handle].visible = false
            Text[v.handle].entity = v
            Text[v.handle].entityPosition = Vector(0,0,v.healthbarOffset)
          end
          if v.health - Damage < 0 then
            Text[v.handle].text = "Kill this mofo! "..math.ceil((v.health + REGEN*3) - Damage)
            Text[v.handle].color = 0xFF0000FF
          elseif active and not Eul then
            Text[v.handle].text = "You need Euls!"
            Text[v.handle].color = 0xE69F2EFF
          elseif active and Eul.cd ~= 0 and not inCombo then
            Text[v.handle].text = "Euls is on cooldown!"
            Text[v.handle].color = 0xE69F2EFF
          elseif active then
            Text[v.handle].text = "Combo-ing!"
            Text[v.handle].color = 0x5EF246FF
          else
            Text[v.handle].text = "HP left: "..math.ceil((v.health + REGEN*3) - Damage)
            Text[v.handle].color = 0xFFFF00FF
          end
          if (v.visible and v.alive) and Text[v.handle].visible ~= true then
            Text[v.handle].visible = true
          elseif (not v.visible or not v.alive) and Text[v.handle].visible == true then
            Text[v.handle].visible = false
          end
        end
      end
    end
    Sleep(100,"Drop")
  elseif not ShowText then
    local Enemies = entityList:GetEntities({type=LuaEntity.TYPE_HERO,illusion=false,team=me:GetEnemyTeam()})
    for i,v in ipairs(Enemies) do
      if Text[v.handle] then
        if Text[v.handle].visible == true then
          Text[v.handle].visible = false
        end
      end
    end
  end

  target = targetFind:GetClosestToMouse(100)

  if Order ~= 0 and not active then
    Order = 0
  elseif Order == 0 and SleepCheck("Combo") and inCombo == true then
    inCombo = false
  end

  if active and target then

    local EulModif = target:FindModifier("modifier_eul_cyclone")
    local EtherealModif = target:FindModifier("modifier_item_ethereal_blade_slow")
    local distance = me:GetDistance2D(target)

    if distance > 625 then
      delay = (distance-625)/me.movespeed
    else
      delay = 0
    end

    if Eul and Eul.cd > 0 and SleepCheck("Time") then
      TimeRemaining = 2500+GetTick()
      Sleep(2500,"Time")
    end

    if Eul and Eul.cd == 0 and Order == 0 then
      me:CastAbility(Eul,target)
      Order = 1
      inCombo = true
    elseif not Eul then
      return
    end

    if EulModif and ((TimeRemaining - GetTick())/1000) < (0.95+(client.latency/1000)+delay) and Order == 1  then
      me:CastAbility(W,target.position)
      Order = 2
      Sleep(500+client.latency+delay*1000,"Cast")
    elseif not Ethereal and EulModif and Order == 2 and SleepCheck("Cast") then
      me:Stop()
      me:CastAbility(Q,target.position)
      Sleep(500+client.latency,"Cast2")
      Order = 3
    elseif Eul.cd ~= 0 and not EulModif then
      if Ethereal and Ethereal.cd == 0 and not EtherealModif and Order == 2 then
        me:CastAbility(Ethereal,target)
        Order = 3
      elseif EtherealModif  and Order == 3 then
        me:CastAbility(Q,target,true)
        if dagon and dagon.cd == 0 then
          me:CastAbility(dagon,target,true)
        end
        if UltimateActive == true then
          me:CastAbility(R,target,true)
        end
        Order = 4
      elseif not Ethereal and Order == 3 and SleepCheck("Cast2") then
        me:Stop()
        if dagon and dagon.cd == 0 then
          me:CastAbility(dagon,target)
          if UltimateActive == true then
            me:CastAbility(R,target,true)
          end
        else
          if UltimateActive == true then
            me:CastAbility(R,target)
          end
        end
        Order = 4
        Sleep(3000, "Combo")
      end
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
    timeremain = math.ceil(30 - client.gameTime)
    statusText4.text = "These messages will disappear in " .. (timeremain) .. " seconds"
    if timeremain < 1 then
      expired = true
    end
  elseif expired then
    statusText.visible = false
    statusText2.visible = false
    statusText3.visible = false
    statusText4.visible = false
    statusText5.visible = false
    ignore = true
  end
end

function DamageCalculation(Enemy)
  local me = entityList:GetMyHero()
  local Eul = me:FindItem("item_cyclone")
  local Ethereal = me:FindItem("item_ethereal_blade")
  local Aghanims = me:FindItem("item_ultimate_scepter")
  local Q = me:GetAbility(1)
  local W = me:GetAbility(2)
  local R = me:GetAbility(4)
  local dagon = me:FindDagon()
  local QDmg = {110,180,250,320}
  local WDmg = {120,160,200,240}
  local RDmg = {450,675,950}
  local DmgQ = 0
  local DmgR = 0
  local DmgD = 0
  local Dmg = 0
  local EReady = false

  if Eul and Eul.cd == 0 then
    Dmg = Dmg + Enemy:DamageTaken(50,DAMAGE_MAGC,me)
  end

  if W and W.cd == 0 and W.level > 0 then
    Dmg = Dmg + Enemy:DamageTaken(WDmg[W.level],DAMAGE_MAGC,me)
  end

  if Ethereal and Ethereal.cd == 0 then
    EReady = true
    Dmg = Dmg + Enemy:DamageTaken((((2*me.intellectTotal) + 75)*1.4),DAMAGE_MAGC,me)
  end

  if Q and Q.cd == 0 and Q.level > 0 then
    if EReady then
      DmgQ = QDmg[Q.level]
      DmgQ = DmgQ*1.4
      DmgQ = Enemy:DamageTaken(DmgQ,DAMAGE_MAGC,me)
      Dmg = DmgQ + Dmg
    else
      DmgQ = Enemy:DamageTaken(QDmg[Q.level],DAMAGE_MAGC,me)
      Dmg = DmgQ + Dmg
    end
  end
  if UltimateActive == true then
    if R and R.cd == 0 and R.level > 0 and not Aghanims then
      if EReady then
        DmgR = RDmg[R.level]
        DmgR = DmgR*1.4
        DmgR = Enemy:DamageTaken(DmgR,DAMAGE_MAGC,me)
        Dmg = DmgR + Dmg
      else
        DmgR = Enemy:DamageTaken(RDmg[R.level],DAMAGE_MAGC,me)
        Dmg = DmgR + Dmg
      end
    elseif R and R.cd == 0 and R.level > 0 and Aghanims then
      Dmg = Dmg + Enemy:DamageTaken(RDmg[R.level],DAMAGE_PURE,me)
    end
  end
  if dagon and dagon.cd == 0 then
    if EReady then
      DmgD = dagon:GetSpecialData("damage")
      DmgD = DmgD*1.4
      DmgD = Enemy:DamageTaken(DmgD,DAMAGE_MAGC,me)
      Dmg = DmgD + Dmg
    else
      DmgD = Enemy:DamageTaken((dagon:GetSpecialData("damage")),DAMAGE_MAGC,me)
      Dmg = DmgD + Dmg
    end
  end

  return Dmg
end

function LuaEntityAbility:CanBeCast()
  return self.cd == 0 and entityList:GetMyHero().mana >= self.manacost
end

function GetHealthRegen(v)
  reg = v.healthRegen
  if v:FindItem("item_heart") then
    if v.healthRegen > (v.maxHealth*0.02) then
      reg = reg - (v.maxHealth*0.02)
    end
  end
  return reg
end

function onLoad()
  if PlayingGame() then
    local me = entityList:GetMyHero()
    if not me or me.classId ~= CDOTA_Unit_Hero_Lina then
      script:Disable()
    else
      registered = true
      script:RegisterEvent(EVENT_TICK,Main)
      script:RegisterEvent(EVENT_KEY,Key)
      script:UnregisterEvent(onLoad)
    end
  end
end

function onClose()
  collectgarbage("collect")
  if registered then
    script:UnregisterEvent(Main)
    script:UnregisterEvent(Key)
    script:RegisterEvent(EVENT_TICK,onLoad)
    registered = false
    target = nil
    active = false
    delay = 0
    Text = {}
    Order = 0
    inCombo = false
    statusText.visible = false
    statusText2.visible = false
    statusText3.visible = false
    statusText4.visible = false
    expired = false
    ignore = false
  end
end

script:RegisterEvent(EVENT_CLOSE,onClose)
script:RegisterEvent(EVENT_TICK,onLoad)

