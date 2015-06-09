--<<The best possible timings for Night Stalker ultimate!>>--

require("libs.SideMessage")
require("libs.Utils")

local Stage = nil

function GenerateSideMessage(heroName,spellName)
  local test = sideMessage:CreateMessage(180,50)
  test:AddElement(drawMgr:CreateRect(10,10,54,30,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/heroes_horizontal/night_stalker")))
  test:AddElement(drawMgr:CreateRect(70,12,62,31,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/other/arrow_usual_left")))
  test:AddElement(drawMgr:CreateRect(140,10,30,30,0xFFFFFFFF,drawMgr:GetTextureId("NyanUI/spellicons/night_stalker_darkness")))
end


function Main(tick)
  if not SleepCheck() then return end
  if not PlayingGame() then return end
  if not entityList:GetMyHero() then return end
  if entityList:GetMyHero().classId ~= CDOTA_Unit_Hero_NightStalker then return end
  if math.ceil(client.gameTime) % 480 == 0 then
    if not Stage then
      GenerateSideMessage()
      Stage = 1
      Sleep(190000,"penis")
      Sleep(2000)
      return
    end
  elseif SleepCheck("penis") and Stage == 1 then
    GenerateSideMessage()
    Stage = nil
  end
end

script:RegisterEvent(EVENT_TICK,Main)
