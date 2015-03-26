--[[

Corporate War mission 6.
The last mission.
friendlyFaction is expecting enemyFaction to jump in and go berserk. Player is supposed to patrol, and then enemyFleet pops in and big battle. player needs to defend the base, which will turn into a ship. failure is the base is destroyed.
Because every campaign should end in carnage.

This mission attempts to claim combatSys, which will either be Salvador or Goddard.

TODO:
all the stufs.

--]]

   bar_name = "%s"
   bar_desc = "%s sits at a booth, rapping his fingers on the table."

   misn_title = "Corporate War"
   misn_desc = "Patrol the %s system, and defend %s against the incoming assault."

   bmsg = {} --beginning messages
   emsg = {} --ending messages
   fmsg = {} --failure messages

   bmsg[1] = [[You walk up to the table %s is at, and once again sit down in the booth across from him. He nods at you in acknowledgement. "Good job so far. Our prototype is almost done, and we have you to thank for that. Now listen, %s is mad. Understandably. And they plan on retaliating. We have solid intelligence that they are on their way here to try and destroy %s. Will you help us?" He pauses, looking at you expectantly.]]
   bmsg[2] = [[%s nods grimly. "Good. We already have ships flying around out there. We are patching in all the friendly ships into the stations radar, so we should see them pretty quick if they jump in. Also, I don't think it needs to be said, but please don't jump or land before this is over. We need your help. Get up there as soon as you can, and good luck. I'll have some credits ready for you when you get back." He waves at you as you leave the booth.]]

   fmsg[1] = [[%s grimaces as you tell him no. "Alright, I'm sure you have your reasons. If you change your mind, come back and talk to me. Hopefully there will still be time." He turns away as you get up to go.]] --player said no in the bar
   fmsg[2] = [[As soon as you finish your jump, your comm blares to life, and you recognize the voice of %s. "You jumping out was a stupid move. You left us on our own. We pushed them out, but they may come back. Come talk to me again if you get a chance." The comm falls silent.]] --player jumped early
   fmsg[3] = [[You guide your ship through the atmosphere, hoping to land soon, when your comm comes to life with %s on the other end. "I'm wondering why you thought it was a good idea to desert us. We pushed them out this time, but they may come back. Come talk to me again and we might be able to work something out." The comm falls silent just as you see the docks peek over the horizon.]] --player landed early/wrong

   emsg[1] = [[]]

   osd = {}
   osd[1] = "Patrol the %s system."
   osd[2] = "Defend %s from the incoming assault."
   osd[3] = "Return to %s."

function create ()

   friendlyFaction = faction.get(var.peek("corpWarFaction"))
   enemyFaction = faction.get(var.peek("corpWarEnemy"))

   if friendlyFaction == faction.get("Goddard") then
      handlerName = "Eryk"
      combatAsset, combatSys = planet.get("Manuel Station")
   else
      handlerName = "Thregyn"
      combatAsset, combatSys = planet.get("Krain Station")
   end

   if not misn.claim(combatSys) then
      mission.finish(false)
   end

   bar_name = bar_name:format(handlerName)
   bar_desc = bar_desc:format(handlerName)

   misn.setNPC(bar_name, "neutral/male1")
   misn.setDesc(bar_desc)
   
   misn_reward = 300000 + faction.playerStanding(friendlyFaction) * 5000 
   
   osd[1] = osd[1]:format(combatSys:name())
   osd[2] = osd[2]:format(combatAsset:name())
   osd[3] = osd[3]:format(combatAsset:name())

end


function accept ()

   bmsg[1] = bmsg[1]:format(handlerName,enemyFaction:name(),combatAsset:name())
   bmsg[2] = bmsg[2]:format(handlerName)
   fmsg[1] = fmsg[1]:format(handlerName)

   if not tk.yesno(misn_title,bmsg[1]) then
      tk.msg(misn_title,fmsg[1])
      misn.finish(false)
   end
   
   misn.accept()
   tk.msg(misn_title, bmsg[2])
   misn.setTitle(misn_title)
   misn.setReward(misn_reward)
   misn.setDesc(misn_desc)
   misnMarker = misn.markerAdd(combatSys,"high")

   missionStatus = 1
   empireStanding = faction.get("Empire"):playerStanding() --we don't want empire rep to suffer because of this campaign.

   misn.osdCreate(misn_title,osd)
   misn.osdActive(missionStatus)

   hook.takeoff("takingoff") --main mission hook.
   hook.jumpin("jumper") --pretty much gonna be an auto-fail
   hook.land("lander") --mission end or fail.
end

function takingoff()
   --we actually don't care about the patrolling. just have a random timer for when "enemyfleet" jumps in.
   --add in friendly ships, etc. don't really care about where, as there's no fleets.
   numFriendlyFighters = rnd.rnd(18,25)
   for i = 1, numFriendlyFighters do
      rndX = rnd.rnd(-10000,10000)
      rndY = rnd.rnd(-10000,10000)
      newFF = pilot.add(friendlyFaction:name() .. " Lancelot",nil,vec2.new(rndX,rndY))
      newFF[1]:setVisible()
      newFF[1]:setFriendly()
      newFF[1]:setNoLand()
      newFF[1]:setNoJump()
   end

   numFriendlyCaps = rnd.rnd(2,5)
   if friendlyFaction:name() == "Goddard" then
      friendlyCaps = "Goddard Goddard"
   else
      friendlyCaps = "Krain Kestrel"
   end
   for i = 1, numFriendlyCaps do
      rndX = rnd.rnd(-10000,10000)
      rndY = rnd.rnd(-10000,10000)
      newFC = pilot.add(friendlyCaps,nil,vec2.new(rndX,rndY))
      newFF[1]:setVisible()
      newFF[1]:setFriendly()
      newFF[1]:setNoLand()
      newFF[1]:setNoJump()
   end
   
   --we need to make the station into a ship too, so it can get destroyed.
   basePos = combatAsset:pos()
   if friendlyFaction:name() == "Goddard" then
      diff.apply("Corporate War Manuel Station")
      theHQ = pilot.add("Manuel Station",nil,basePos)
   else
      diff.apply("Corporate War Krain Station")
      theHQ = pilot.add("Krain Station",nil,basePos)
   end
   theHQ[1]:setVisible()
   theHQ[1]:setFriendly()
   theHQ[1]:control()
   theHQ[1]:brake()

   hook.pilot(theHQ[1],"exploded","hqDead")


   --now that that's all done, hook the enemy fleet jumping in.
   rndTimer = rnd.rnd(10000,60000) --random timer between 10 seconds and 1 minute.
   hook.timer(rndTimer,"enemyFleetArrival")
end

function enemyFleetArrival()
   --now the fun begins!

end

function hqDead()
   --dangit, the hq is ded!
end

function jumper()
   --pretty much should be no reason the player jumps until the baddies are destroyed.
   if missionStatus ~= 3 then
      tk.msg(misn_title,fmsg[2])
      misn.finish(false)
   end
end

function lander()
   --same as jumper, no reason to land until the baddies are destroyed.
   if missionStatus ~= 3 then
      tk.msg(misn_title,fmsg[3])
      misn.finish(false)
   elseif missionStatus == 3 and planet.cur() == combatAsset then
      emsg[1] = emsg[1]:format(***BLERG***) --still need to write emsgs
      tk.msg(misn_title,emsg[1])
      player.pay(misn_reward)
      faction.modPlayerRaw("Empire",empireStanding - faction.get("Empire"):playerStanding())
      --need to come up with and apply the tech unidiff adding the new ship.
      misn.finish(true)
   end
end

function abort()
   misn.finish(false)
end
