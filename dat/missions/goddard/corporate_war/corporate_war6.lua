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
   hqbm = {} --headquarters broadcast messages.

   bmsg[1] = [[You walk up to the table %s is at, and once again sit down in the booth across from him. He nods at you in acknowledgement. "Good job so far. Our prototype is almost done, and we have you to thank for that. Now listen, %s is mad. Understandably. And they plan on retaliating. We have solid intelligence that they are on their way here to try and destroy %s. Will you help us?" He pauses, looking at you expectantly.]]
   bmsg[2] = [[%s nods grimly. "Good. We already have ships flying around out there. We are patching in all the friendly ships into the stations radar, so we should see them pretty quick if they jump in. Also, I don't think it needs to be said, but please don't jump or land before this is over. We need your help. Get up there as soon as you can, and good luck. I'll have some credits ready for you when you get back." He waves at you as you leave the booth.]]

   fmsg[1] = [[%s grimaces as you tell him no. "Alright, I'm sure you have your reasons. If you change your mind, come back and talk to me. Hopefully there will still be time." He turns away as you get up to go.]] --player said no in the bar
   fmsg[2] = [[As soon as you finish your jump, your comm blares to life, and you recognize the voice of %s. "You jumping out was a stupid move. You left us on our own. We pushed them out, but they may come back. Come talk to me again if you get a chance." The comm falls silent.]] --player jumped early
   fmsg[3] = [[You guide your ship through the atmosphere, hoping to land soon, when your comm comes to life with %s on the other end. "I'm wondering why you thought it was a good idea to desert us. We pushed them out this time, but they may come back. Come talk to me again and we might be able to work something out." The comm falls silent just as you see the docks peek over the horizon.]] --player landed early/wrong
   fmsg[4] = [[Your comms start firing off static intermixed with short,desperate messages. You nav display shows a live view of the station, fire erupting from it as its reactor begins to melt down. You watch, in horror, as escape pods frantically try to clear the blast radius, but for naught, as the explosions finally commence and rip the station apart. You have failed, and the station is no more.]] --the HQ station blows up.

   emsg[1] = [[Having safely defended %s from being destroyed, you land on the station to see people rushing around and checking systems. %s greets you as you disembark, all smiles. "That was rather exhilirating! Great job, %s." %s pats you on the back. "We have some important news to share. If you'd be so kind as to follow me?" You nod, and %s leads you off the docks and down a corridor. Before long, you are lead into an open room, with many anxious reporters standing around. %s guestures for you to sit.]]
   emsg[2] = [[A man dressed in a slick suit steps up to a podium in the front of the room, and everyone quickly falls silent. "Thank you all for being here. We were unaware that %s was going to attack us today, but that only sheds some light on our competition and their ethis." He adjusts his tie as you roll your eyes. "This station was defended in no small part by %s, who has honoured us with his presence today." With this, the man guestures at you as the reporters applaud politely. "The real reason we have asked you hear today, is that we are launching a new line of ships. Available starting today, these new ships are smaller and are capable of fighting with the best of them. They have the latest military-grade technology, and we are confident these ships will have a long-term impact on the galaxy." The reporters again clap, as a picture of the new ship is displayed against the wall behind the man. Impressive.]]
   emsg[3] = [[As the meeting ends, %s shakes your hand. "It's been a pleasure working with you, %s. You've been a great asset to this company, and to the development of that ship. If you're ever in the system again, drop by for some drinks!" And with that, %s walks away, leaving you with a feeling of accomplishment.]]

   hqbm[1] = [[We are detecting high numbers of %s ships entering the system!]]
   hqbm[2] = [[Our sensors are showing an all clear. Good job, folks.]]
   hqbm[3] = [[The station is at critical! Reactor melting down! ...]]

   osd = {}
   osd[1] = "Patrol the %s system."
   osd[2] = "Defend %s from the incoming assault."
   osd[3] = "Return to %s."


   newsArticle = { title = [[%s releases new ship.]],
                   description = [[%s has just recently announced the launch of a new line of ships, based on their prior successful capital ships. "The MkII is smaller, sleeker, and filled to the brim with next-gen military grade technology." Stated a press release issued earlier today. %s stocks have already increased by 2.7 points, and are expected to continue to climb.]],
                 }


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
      enemyCaps = "Krain Kestrel"
   else
      friendlyCaps = "Krain Kestrel"
      enemyCaps = "Goddard Goddard"
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
      theHQ = pilot.add("Manuel Station",nil,basePos)
      diff.apply("Corporate War Manuel Station")
   else
      theHQ = pilot.add("Krain Station",nil,basePos)
      diff.apply("Corporate War Krain Station")
   end
   theHQ[1]:setVisible()
   theHQ[1]:setHilight()
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
   missionStatus = 2
   misn.osdActive(missionStatus)

   hqBroadcast = hqBroadcast:format(enemyFaction:name())
   theHQ[1]:broadcast(hqBroadcast)

   sysJumps = combatSys:jumps()
   combatJump = sysJumps[1]:dest()

   enemyFleet = {}
   numEnemyFighters = rnd.rnd(21,30)
   for i = 1, numEnemyFighters do
      newEF = pilot.add(enemyFaction:name() .. " Lancelot",nil,combatJump)
      newEF[1]:setVisible()
      newEF[1]:setHostile()
      newEF[1]:setNoLand()
      newEF[1]:setNoJump()
      hook.pilot(newEF[1],"exploded","enemyDead")
      table.insert(enemyFleet,newEF[1])
   end
   
   numEnemyCaps = rnd.rnd(3,7)
   for i = 1, numEnemyCaps do
      newEC = pilot.add(enemyCaps,nil,combatJump)
      newEC[1]:setVisible()
      newEC[1]:setHostile()
      newEC[1]:setNoLand()
      newEC[1]:setNoJump()
      hook.pilot(newEC[1],"exploded","enemyDead")
      table.insert(enemyFleet,newEC[1])
   end
end

function hqDead()
   --dangit, the hq is ded!
   --mission finishes, no reward, station is gone forevers!
   --when it's done, apply the unidiff that allows enemyFaction's ship to be put on sale.
   tk.msg(misn_title,fmsg[4])
   diff.apply("Add " .. enemyFaction:name() .. " MkII")

   newsarticle.title = newsarticle.title:format(enemyFaction:name())
   newsarticle.description = newsarticle.description:format(enemyFaction:name(),enemyFaction:name())
   news.add("Generic",newsarticle.title,newsarticle.description)

   mission.finish(true)
end

function enemyDead()
   --see if the enemy fleet has been defeated.
   numEnemyDead = numEnemyDead or 0
   if numEnemyDead == #enemyFleet then
      theHQ[1]:broadcast(hqbm[2])
      missionStatus = 3
      if friendlyFaction:name() == "Goddard" then
         diff.remove("Corporate War Manuel Station")
      else
         diff.remove("Corporate War Krain Station")
      end
      theHQ[1]:rm()
   end
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

      emsg[1] = emsg[1]:format(planet.cur(),handlerName,player.name(),handlerName,handlerName,handlerName)
      emsg[2] = emsg[2]:format(enemyFaction:name(),player.name())
      emsg[3] = emsg[3]:format(handlerName,player.name(),handlerName)
   
      tk.msg(misn_title,emsg[1])
      player.pay(misn_reward)
      faction.modPlayerRaw("Empire",empireStanding - faction.get("Empire"):playerStanding())
      if friendlyFaction:name() == "Goddard" then
         diff.apply("Add Goddard MkII")
      else
         diff.apply("Add Kestrel MkII")
      end

      newsarticle.title = newsarticle.title:format(friendlyFaction:name())
      newsarticle.description = newsarticle.description:format(friendlyFaction:name(),friendlyFaction:name())
      news.add("Generic",newsarticle.title,newsarticle.description)
      
      --campaign is over, so pop the variables.
      var.pop("corpWarFaction")
      var.pop("corpWarEnemy")
      var.pop("corpWarStolen")

      misn.finish(true)
   end
end

function abort()
   misn.finish(false)
end
