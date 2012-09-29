--[[misn title - the egress]]
--[[this mission begins with the frenetic nasin wanting to escape
	the wringer due to being overwhelmed by house sirius. the player
	loads up with as many nasin as their vessel will carry, and takes
	them to seek refuge in the ingot system on planet ulios, where they
	begin to rebuild and plan.... (ominous music).
	this mission is designed to be the end of part 1, and is supposed
	to be very hard, and slightly combat oriented, but more supposed to
	involve smuggling elements.]]
	
lang = naev.lang()

--beginning messages
bmsg = {}
bmsg[1] = [[You run up to Draga, who has a look of desperation on his face. He talks to you with more than a hint of urgency.
   "We need to go, now. The Sirius are overwhelming us, they're about to finish us off. Will you take me and as many Nasin as you can carry to %s in %s? I swear, if you abort this and jettison those people into space, I will hunt you down and destroy you." A man bursts through the bar doors, and looking around, runs straight at Draga. Draga, apparently recognizing the man, catches him. "What is it, Jason?" Draga asks hurriedly. The young boy, Jason, has a large smile on his face, and as he catches his breath, he leans in and begins talking hurriedly. "I just came from the scanner systems deck, and we have detected a gravitational anamoly, a little farther out from The Wringer." You, and Draga, wear confused expressions on your faces. Obviously the importance of the news is lost on you both. The boy, seeing this, begins again. "We detected a new gravitational anamoly. Upon further scanning, we discovered a large outflux of tachyons, as well as quark–gluon plasma emissions, and highly unstable pentaquark xavi radiation. In short, its a new wormhole! It's faint and very hard to detect, but its there! Initial scans indicate the exit is in Kiwi." Draga looks excited. "Sirichana smiles on us again! Can you head to the communications bridge, and have the coordinates sent to all confirmed Nasin vessels? Tell them to head to that!" Draga smiles gleefully at you. "Lets go! Will you help?" He leans in, impatient for an answer.]]
bmsg[2] = [[You lead Draga out of the bar and into the landing bay you landed in. Refugees are running about, hoping to get aboard some ship or another. Chaos reigns. Draga asks you what your tonnage is as you push and shove, trying to get through the panicked crowd. You finally get to your ship, and you notice Draga is no longer with you. You look around, and you see him talking to people and pointing to your ship. Those people look towards you with hope in their eyes. You lock your gaze with a young woman in her mid-twenties, carrying a small child, and wave her over. She doesn't need anymore encouragment, and soon a small crowd has formed around you, trying to get into the ship. You try and keep order as a rather large man tries to shove his way in past an older couple. You lay him out on the deck, and make it clear he can't come aboard. To make matters worse, the peope panic as gunfire erupts out on the far end of the bay. You look, and a small skirmish has broken out between some Sirius soldiers who just landed and a small group of Nasin. The Sirius are definitely winning, and working their way towards you.]]
bmsg[3] = [[As the gunfire gets nearer, Draga appears out of the crowd and yells at you to get the ship going and take off. You get in the cabin and begin rising into the air, and you see Draga running back into the bay to help a woman run with her children to a small inter-planetary skiff. Some Sirius soldiers, who extracted the skirmish, run and catch up with him, obviously knowing who he was. Draga must've been a wanted man. They catch up with him, giving him three shots in the chest. The last thing you see as you take off was Draga in a pool of blood, and the woman being dragged off by the soldiers. The children are no where in site, and you decide it'd probably be best if you didn't look too hard. You rocket out of there, and begin prepping to get those people to safety.]]

--ending messages
emsg = {}
emsg[1] = [[You land on %s, and open the bay doors. You are amazed at how many people Draga had helped get into the cargo hold. The people exit in a suprisingly ordered manner, and are helped out by some people who look like they were expecting you. It is a stark contrast to the landing area when you took off. You help out the last few people, who are grateful to you, and walk down into the bay. A man walks up to you, looking exhausted but yet excited that so many people walked out of your ship.]]
emsg[2] = [[The man offers his hand, and begins to speak. 
   "Hello, my name is Jimmy. Thank you for helping all these people." He gestures to the refugees, who are being helped by some officials. "I am grateful. I've heard about you, from Draga, and I will be forever in your debt. All I can manage right now is this, so consider me in your debt."
   He presses a credit chip in your hand, and begins to walk away. As though remembering something, he stops, and turns around back to you. "I almost forgot. The young man, Jason, whom you and Draga talked to before you left, wanted me to give you something. Its a jump scanner, especially built to detect hidden jumps. Its in the storage area right now, but I'll have someone bring it out to you." With a smile and a nod, he runs off to see if any of the refugees need help.]]

--mission osd
osd = {}
osd[1] = "Fly the refugees to %s in the %s system."

--random odds and ends
abort_msg_space = [[You decide that this mission is just too much. You open up the cargo doors and jettison the %d people out to fend for themself. The Nasin, and the Sirius, will hate you forever, but you did what you had to do.]]
misn_title = "The Egress"
npc_name = "Draga"
bar_desc = "Draga is running around, helping the few Nasin in the bar to get stuff together and get out."
misn_desc = "Assist the Nasin refugees by flying to %s in %s, and unloading them there."

function create()
   --this mission make no system claims.
   --initalize your variables
   nasin_rep = faction.playerStanding("Nasin")
   misn_tracker = var.peek("heretic_misn_tracker")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01
   homeasset = planet.cur()
   targetasset, targetsys = planet.get("Ulios") --this will be the new HQ for the nasin in the next part.
   free_cargo = pilot.cargoFree(pilot.player())
   people_carried =  (16 * free_cargo) + 7 --average weight per person is 62kg. one ton / 62 is 16. added the +7 for ships with 0 cargo.

   --set some mission stuff
   misn.setNPC(npc_name,"neutral/thief2")
   misn.setDesc(bar_desc)
   misn.setTitle = misn_title
   misn.setReward = reward
   --format your strings, yo!
   bmsg[1] = bmsg[1]:format(targetasset:name(),targetsys:name())
end

function accept()
   --inital convo. Kept it a yes no to help with the urgent feeling of the situation.
   if not tk.yesno(misn_title,bmsg[1]) then
      misn.finish ()
   end
   misn.accept()

   misn_desc = misn_desc:format(targetasset:name(),targetsys:name())
   misn.setDesc(misn_desc)
   osd[1] = osd[1]:format(targetasset:name(),targetsys:name())
   misn.osdCreate(misn_title,osd)
   misn.osdActive(1)
   diff.apply("hereticdiff1")
   jump.get(system.get("Suna"), system.get("Kiwi")):setKnown()
   player.allowSave(false) -- so the player won't get stuck with a mission he can't complete.
   tk.msg(misn_title,bmsg[2])
   tk.msg(misn_title,bmsg[3])
   --convo over. time to finish setting the mission stuff.

   misn.markerAdd(targetsys,"plot")
   refugees = misn.cargoAdd("Refugees",free_cargo)
   player.takeoff()
   --get the hooks.

   hook.takeoff("takeoff")
   hook.jumpin("jumper")
   hook.jumpout("lastsys")
   hook.land("misn_over")
end

function takeoff()
   if takeoff_check == nil then
      takeoff_check = 1
      pilot.clear()
      pilot.toggleSpawn("Sirius",false)

      pilot.add("Sirius Assault Force",sirius,vec2.new(rnd.rnd(-4500,4500),rnd.rnd(-4500,4500))) --left over fleets from the prior mission.
      pilot.add("Sirius Assault Force",sirius,vec2.new(rnd.rnd(-4500,4500),rnd.rnd(-4500,4500)))
      pilot.add("Nasin Sml Civilian",nil,homeasset) --other escapees.
      pilot.add("Nasin Sml Civilian",nil,homeasset)
      pilot.add("Nasin Sml Civilian",nil,homeasset)
      pilot.add("Nasin Sml Civilian",nil,homeasset)
      pilot.add("Nasin Sml Civilian",nil,homeasset)
      pilot.add("Nasin Sml Attack Fleet",nil,homeasset) --these are trying to help.
      pilot.add("Nasin Sml Attack Fleet",nil,homeasset)
      pilot.add("Nasin Sml Attack Fleet",nil,homeasset)
   end
end

function lastsys()
   last_sys_in = system.cur()
   if j_c == nil then
      j_c = 8
   else
      j_c = j_c - 1
   end
end

function jumper() --several systems where the sirius have 'strategically plced' an assault fleet to try and kill some nasin.
   pilot.clear()
   pilot.toggleSpawn("Sirius",false)

   dangersystems = {
   system.get("Neon"),
   system.get("Pike"),
   system.get("Vanir"),
   system.get("Aesir"),
   system.get("Eiderdown"),
   system.get("Lapis"),
   system.get("Ruttwi"),
   system.get("Esker"),
   system.get("Gutter")
   }

   for i,sys in ipairs(dangersystems) do
      if system.cur() == sys then
         pilot.add("Sirius Assault Force",sirius,vec2.new(rnd.rnd(-3000,3000),rnd.rnd(-3000,3000)))
      end
   end

   chance_badguy = rnd.rnd(1,3)
   if system.faction(system.cur()) == faction.get("Sirius") and system.cur() ~= system.get("Tartan") then
      for i = 1,chance_badguy do
         pilot.add("Sirius Med Patrol",nil,vec2.new(rnd.rnd(-3000,3000),rnd.rnd(-3000,3000)))
      end
   end
   if j_c > 1 then
      local chance_help,chance_civvie = rnd.rnd(1,math.ceil(j_c/2)),rnd.rnd(1,j_c) --attack fleet and civvies are meant as a distraction to help the player.
      for i = 1,chance_help do
	 pilot.add("Nasin Sml Attack Fleet",nil,last_sys_in)
      end
      for i = 1,chance_civvie do
	 pilot.add("Nasin Sml Civilian",nil,last_sys_in)
      end
   end
   
   if system.faction(system.cur()) ~= faction.get("Sirius") and system.cur() ~= system.get("Tartan") then
      player.allowSave(true)
   end
end

function misn_over() --arent you glad thats over?
   if planet.cur() == planet.get("Ulios") then
      emsg[1] = emsg[1]:format(targetasset:name())
      tk.msg(misn_title,emsg[1]) --introing one of the characters in the next chapter.
      tk.msg(misn_title,emsg[2])

      player.pay(reward)
      player.addOutfit("Hidden Jump Scanner")
      misn.cargoRm(refugees)
      misn_tracker = misn_tracker + 1
      faction.modPlayer("Nasin",8) --big boost to the nasin, for completing the prologue
      faction.modPlayer("Sirius",-5) --the sirius shouldn't like you. at all.
      var.push("heretic_misn_tracker",misn_tracker)
      misn.osdDestroy()

      player.allowSave(true)
      misn.finish(true)
   end
end

function abort()
   abort_msg_space = abort_msg_space:format(people_carried)
   tk.msg(misn_title,abort_msg)
   --var.push("heretic_misn_tracker",-1) --if the player jettisons the peeps, the nasin will not let the player fly with them anymore.
   misn.osdDestroy()
   player.allowSave(true)
   misn.finish(false)
end
