--<<Roshan Slayer script by Phantometry version 1.1>>--
--[[   
                                                                      
                                ██╗   ██╗██████╗ ███████╗ █████╗ 
                                ██║   ██║██╔══██╗██╔════╝██╔══██╗
                                ██║   ██║██████╔╝███████╗███████║
                                ██║   ██║██╔══██╗╚════██║██╔══██║
                                ╚██████╔╝██║  ██║███████║██║  ██║
                                 ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
                                                ██████╗  ██████╗ ███████╗██╗  ██╗ █████╗ ███╗   ██╗
                                                ██╔══██╗██╔═══██╗██╔════╝██║  ██║██╔══██╗████╗  ██║
                                                ██████╔╝██║   ██║███████╗███████║███████║██╔██╗ ██║
                                                ██╔══██╗██║   ██║╚════██║██╔══██║██╔══██║██║╚██╗██║
                                                ██║  ██║╚██████╔╝███████║██║  ██║██║  ██║██║ ╚████║
                                                ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝
                                                                                             
                                                          ██████  ██▓    ▄▄▄     ▓██   ██▓▓█████  ██▀███  
                                                        ▒██    ▒ ▓██▒   ▒████▄    ▒██  ██▒▓█   ▀ ▓██ ▒ ██▒
                                                        ░ ▓██▄   ▒██░   ▒██  ▀█▄   ▒██ ██░▒███   ▓██ ░▄█ ▒
                                                          ▒   ██▒▒██░   ░██▄▄▄▄██  ░ ▐██▓░▒▓█  ▄ ▒██▀▀█▄  
                                                        ▒██████▒▒░██████▒▓█   ▓██▒ ░ ██▒▓░░▒████▒░██▓ ▒██▒
                                                        ▒ ▒▓▒ ▒ ░░ ▒░▓  ░▒▒   ▓▒█░  ██▒▒▒ ░░ ▒░ ░░ ▒▓ ░▒▓░
                                                        ░ ░▒  ░ ░░ ░ ▒  ░ ▒   ▒▒ ░▓██ ░▒░  ░ ░  ░  ░▒ ░ ▒░
                                                        ░  ░  ░    ░ ░    ░   ▒   ▒ ▒ ░░     ░     ░░   ░ 
                                                              ░      ░  ░     ░  ░░ ░        ░  ░   ░     
                                                                                      ░ ░                     
                                                   
]]
require("libs.Utils")
require("libs.ScriptConfig")
require("libs.Animations")




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
local Font1 = drawMgr:CreateFont("Font","Tahoma",0.01671875*ScreenY,0.4375*ScreenX)
local statusText = drawMgr:CreateText((x+1320)*monitor,(y+25)*monitor,0x36F570B3,"Roshan Slayer is on his way!",Font1) statusText.visible = false
local statusText1 = drawMgr:CreateText((x+1410)*monitor,(y+605)*monitor,0x41FAFA80,"Script version - 1.1",Font1) statusText1.visible = false
local statusText2 = drawMgr:CreateText((x+1420)*monitor,(y+620)*monitor,0x41FAFA80,"Coded by - Phantometry",Font1) statusText2.visible = false

function Load()
  local me = entityList:GetMyHero()

  if PlayingGame() then
    if (me.classId ~= CDOTA_Unit_Hero_Ursa) then
      script:Disable()
    else
      registered = true
      statusText.visible = true
	  statusText1.visible = true
	  statusText2.visible = true
      script:RegisterEvent(EVENT_TICK,Main)
      Sleep(900)
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
      statusText.text = "Roshan Slayer is on his way!"
      statusText.color = 0x36F570B3
    else
      Step = 1337
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

    if Step == 0 and me:DoesHaveModifier("modifier_fountain_aura_buff") then
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
      Sleep(2700)
	elseif Step == 0 then 
	 Step = 1337
    end

    if Step == 1 and roshan and me:GetDistance2D(roshan) > (380 - client.latency/5.5) then
      me:Move(Vector(4282,-1816,100))
      Step = 2.5
	  Sleep(500)
	  elseif Step == 2.5 then 
	  me:AttackMove(Vector(4282,-1816,100))
	  Step = 2
    elseif Step == 2 and Animations.CanMove(me) then
      me:Move(Vector(3478,-1969,100))
      Step = 3
    elseif Step == 3 and roshan and me:GetDistance2D(roshan) < (275 + client.latency/5.5) and me:GetDistance2D(Vector(3478,-1969,100)) < 3 then
      me:Attack(Ward[1])
      me:Stop()
      Step = 1
    end
  end
end

function Roshan(event)
  if event.name == "dota_roshan_kill" then
    statusText.visible = false
	statusText1.visible = false
	statusText2.visible = false
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
