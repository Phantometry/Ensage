--<<Roshan Slayer beta version>>--

require("libs.Utils")
require("libs.ScriptConfig")


config = ScriptConfig.new()
config:SetParameter("ursamove", "K", config.TYPE_HOTKEY)
config:Load()

local ursamove = config.ursamove
local ursamove1 = true
local Step = 0
local penis = false

local x,y = 5, 55
local monitor = client.screenSize.x/1600
local ScreenX = client.screenSize.x
local ScreenY = client.screenSize.y
local Font = drawMgr:CreateFont("Font","Tahoma",0.02071875*ScreenY,0.4375*ScreenX)
local Font1 = drawMgr:CreateFont("Font","Tahoma",0.01671875*ScreenY,0.4375*ScreenX)
local statusText = drawMgr:CreateText((x+1320)*monitor,(y+25)*monitor,0x39B8E3B3,"Roshan slayer is on his way!",Font1) statusText.visible = true

function Load()
  local me = entityList:GetMyHero()

  if PlayingGame() then
    if (me.classId ~= CDOTA_Unit_Hero_Ursa) then
      script:Disable()
    else
      registered = true
      script:RegisterEvent(EVENT_TICK,Main)
      script:RegisterEvent(EVENT_DOTA,Roshan)
      script:RegisterEvent(EVENT_KEY,Key)
      script:UnregisterEvent(Load)
    end
  end
end

function Key()
  if client.chat or client.console or client.loading then return end
  local me = entityList:GetMyHero()


  if IsKeyDown(ursamove) then
    ursamove1 = not ursamove1
    if ursamove1 == true then
      statusText.text = "Roshan slayer is on his way!"
      statusText.color = 0x39B8E3B3
    else
      statusText.text = "Fuck this shit I'm not doing it!"
      statusText.color = 0xF2754BB3
    end
  end
end

function Main(tick)
  if not SleepCheck() or client.paused then return end
  local me = entityList:GetMyHero()
  if not me then return end

  if ursamove1 then
    local Ward = entityList:GetEntities(function(x) return x.classId == CDOTA_NPC_Observer_Ward and x:GetDistance2D(me) <= 1000 end)
    local mp = entityList:GetMyPlayer()
    local roshan = entityList:GetEntities({classId = CDOTA_Unit_Roshan}) [1]

    if Step == 0 then
      if not penis then
        mp:BuyItem(29)
        mp:BuyItem(46)
        mp:BuyItem(42)
        mp:LearnAbility(me:GetAbility(3))
        penis = true
      end
      if me:FindItem("item_tpscroll") and me:FindItem("item_ward_observer") then
        me:CastItem("item_tpscroll",Vector(1360,-1240,100),true)
        me:CastItem("item_ward_observer", Vector(3805,-2382,400), true)
        Step = 1337
      end
    elseif Step == 1337 and not me:FindItem("item_ward_observer") then
      me:AttackMove(Vector(4282,-1816,100))
      Step = 2
      Sleep(3000) return
    end

    if Step == 1 and roshan and me:GetDistance2D(roshan) > 352.5 then
      me:AttackMove(Vector(4282,-1816,100))
      Step = 2
      Sleep(1700)
    elseif Step == 2 then
      me:Move(Vector(3478,-1969,100))
      Step = 3
    elseif Step == 3 and roshan and me:GetDistance2D(roshan) < 295.5 and me:GetDistance2D(Vector(3478,-1969,100)) < 3.5 then
      me:Attack(Ward[1])
      me:Stop()
      Step = 1
    end
  end
end

function Roshan(event)
  if event.name == "dota_roshan_kill" then
    statusText.visible = false
    collectgarbage("collect")
    script:UnregisterEvent(Main)
  end
end

function Close()
  collectgarbage("collect")
  if registered then
    Text = {}
    penis = false
    script:UnregisterEvent(Main)
    script:UnregisterEvent(Key)
    script:RegisterEvent(EVENT_TICK,Load)
    registered = false
  end
end

script:RegisterEvent(EVENT_CLOSE,Close)
script:RegisterEvent(EVENT_TICK,Load)
