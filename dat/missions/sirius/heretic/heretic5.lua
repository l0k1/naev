--[[misn title - the shutdown]]
--[[in this mission, the nasin are back, and are requesting the players help. only this time around, they are on the offense. seriously. this "chapter" is going to be a lot more combat oriented than the first, including large scale battles between house sirius and the nasin heretics, who arent playing nice, even with civilian populations. think terrorism.  this mission starts out as a scouting run for an impending invasion force. emphasis here is more on speed and stealth.
Draga, the players handler and key point of contact with the nasin, died in the last mission of the Prologue from Sirius infiltrators, and now we get into the meat of characters.
Clase Homons - The overseer of the section that the player will be working in during this chapter. Skrat is a colonel of sorts, as the player is inducted into the militia.
Jimmy Thomorr - A "recruiter" with the nasin, who is there to talk the player into joining.
Mase Attes - The players commander.
Marton Heson - A pilot who flies with the player, and offers advice.]]

include("proximity.lua")

lang = naev.lang()
misn_title = "The Shutdown"

--Opening messages

bmsg = {}
bmsg[1] = [[You walk up to the two serious looking men, wondering why you are even approaching. Thats when you realize that you know the one on the left. Jimmy, the one whom you had met when you landed on Ulios with all the Nasin refugees. Upon seeing you approach, they motion for you to sit down. The one on the left, Jimmy, begins the conversation. "%s! It is good to finally get to sit down with you. My name is Jimmy Thomorr, in case you had forgotten, and this is Mase Attes, and we are fortunate members of the Nasin. We are very glad to have you come and join us."]] --playername
bmsg[2] = [[Thomorr guestures for you to sit down. "When the Sirius launched their attack on our assets and churches, we suffered greatly. They didn't even stop at the men. They imprisoned women, children, even the elderly. Any one resisting was shot. They even went as far as to attempt undercover operations on all of our locations they knew about outside of their space. They nearly wiped us out, but we survived. We have several major centers operating now, and things are looking up. We've been activily recruiting, not hiding in the dark, and we feel it is time to strike back against those oppresive tyrants."]]
bmsg[3] = [[Mase Attes pulls out a binder, and opens it. "This is a rough idea of what we've had going on in our navy since the attack." He points out some figures and a couple graphs, and begins to explain. "The Nasin really had no true organized navy prior to the attack on The Wringer, as we had no reason. We had a roughly hewn, disorganized militia. After the attack, we decided we wanted revenge. We needed revenge. So our leadership decided that we needed a true navy, and began hiring pilots from amongst our ranks, as well as buying up any and all combat worthy vessels to equip those pilots with."]]
bmsg[4] = [[Thomorr, at this point, coughs and interupts Attes' monologue. "Where you come in, %s, is that we need you. You are a decent pilot, and you already own a good vessel. Our navy... suffered... during the Sirius attack, and we are looking for a few good pilots to help our navy out. We can't guarantee you anything, but we can offer you prestige, honor, and a few credits. As well as a chance to take out some Sirius. We want you in the Nasin Navy. What do you say?]] --playername
bmsg[5] = [[Attes smiles broadly. "Good. Good. Well, you will be working closely with me, as I will be your immediate commander. I'm glad to have you on board." He shakes your hand enthusiastically. "I have a current wing under me of about 6 ships. You will be flying with us. The fleet is about 18 ships."]]
bmsg[6] = [[Thomorr shakes his head and gives Attes an "I told you he was about the money" look. He turns to you. "We will pay, and promote you, based on your loyalty to us and your performance. It will be on a per-mission basis. Base pay is 10,000 credits from here on forward. Of course, this is only the base pay. You'll be making much more. This mission, we will pay you %d."]] --reward
bmsg[7] = [[Thomorr and Attes both rise and shake your hand. Thomorr speaks, "Please, take your time. We will be hanging around here if you wish to come back."]]
bmsg[8] = [[Thomorr rises in anger, and Attes reaches over the table and lands a right hook on your jaw. You topple over backwards, and by the time you rise up, they've already stormed off. Your glad to be done with this.]]
bmsg[9] = [[Attes seems quite happy at the moment, and he continues. "Well, we have an important mission to go on. We are beginning our retaliation on House Sirius, and we are issuing a coordinated attack on about 10 outlying military installations. More guerilla warfare, mind you. We want to cause chaos. You will be meeting up with the fleet in %s, and attacking %s in %s. After you jump in, several shuttles will jump in and attempt to take that asset. We need to protect them and wipe out any Sirius. You were the last piece of the puzzle. Now, get going!"]] --meetsys, target asset, target system

--Messages displayed after the mission is over.

emsg = {}
emsg[1] = [[You land on %s, grateful to have made it out of the mission alive. These Nasin were getting serious, and the Sirius are getting angry. You land in the hanger and step out of your ship, to be greeted by Mase Attes. He is grinning ear to ear, obviously quite happy at the success of the assault. He claps you on the shoulder, and the two of you begin walking towards the rear of the hanger together. He begins to speak.
"I'm glad you made it out of there. I would hate to have your first mission for me end in your ship getting blown up! It would've looked bad for the fleet." He smiles. "That stuff should only happen with those crazy special forces guys." He shakes his head.]] --homeasset
emsg[2] = [[As though thinking of some grand, new idea, he looks to you with a gleam in his eye. "You know, our special forces just recently formed with our push towards militism. If your performance is good enough under me, I can tell Thomorr to put in a good word for you over there. Crazy stuff, those kids. I've heard rumours of deep interception missions, hunting and assassinating high-ranking officials, and other things that have a high mortality rate. I'm sure they'd love to have a crazy kid like you!"]]
emsg[3] = [[Attes tilts his head slightly, listening to some new information that is coming in through an earpiece. "Good news! We staged an assault on the Sirius assets in another system, and the assault there went well too. We have made some great headway today!" He looks excited and energetic, and apparently the news is spreading to the other Nasin in the hanger. You see several people high-fiving, and another couple hugging. "We have a firm foothold on several Sirius assets. You'll know the systems belong to us if you see Nasin flying around, and a severe lack of Sirius ships. You should be able to land on all the assets in the system, as we have taken all of the starports. There may still be resistance here and there, and they might still appear unfriendly in your nav system, but you should be fine. Just be leery of any counter-attacks."]]
emsg[4] = [[You and Attes reach the back of the hanger, and turn around. You and him survey the myriad of ships in the hanger, both taking off and landing. "You did good out there, %s. I'm glad to have you on board. You should know, your in now. We appreciate your dedication and loyalty." He coughs. "We are planning another assault. Come and meet me in the bar when your ready to take down another Sirius asset. Payment for this mission has already been credited to your account." With this, he shakes your hand gratefully and strides out, leaving you alone at the back of the hanger.]] --playername

--Conversation choices

convo_choice = {}
convo_choice[1] = "I say yes!"
convo_choice[2] = "How much pay are we talking?"
convo_choice[3] = "Give me some time to think about it."
convo_choice[4] = "I don't want any part in this heresy!"

--Random mission info.

npc_name = "Thomorr and Attes"
bar_desc = "You see two men, chatting at one of the tables against the wall."
misn_desc = "Fly to %s and help assault %s."

--In flight pop-up messages

time_to_return = [[Your comm squaks, a little bit of post-jammer feedback giving you a start. The fleet commanders voice drifts into the static, addressing what remains of the fleet. "Good job boys! The Sirius are all dead, and you guys are cleared to come on home. We have the 2nd, 4th and 5th squadrons from 3rd Fleet moving in to patrol the area. Drinks are on me!"]]
shuttles_all_dead = [[You see a flash as the last shuttle explodes. You comm squeals, and the voice of Attes blares to life. "Alright guys, you let all the shuttles explode, so this mission is a failure. Get back to base if you can, we are sounding the retreat." The static cuts out, and you consider this mission an utter failure.]]
shuttles_have_docked = [[The comm station blinks to life, and you see one of the commanders of the marine shuttles. He is broadcasting to all the Nasin ships in the area. "We have all the shuttles landed, and are currently taking command of the station. Resistance is light, we dont expect too much trouble. Thanks for the cover!" The comm channel closes, leaving the ship in silence again.]]
premature_jump = [[You flash out of hyperspace, and almost immediately your comm stations priority channel comes to life. You hear the angry voice of Attes. "You jumped out of the system too early! Thanks for nothing. Get lost kid!"]]
premature_land = [[As soon as you enter the atmosphere, your priority communication channel bleeps, and Attes fills the cabin with his sonorous voice. "We requested that you not land until the mission is complete. The shuttles and your fleet-mates are at risk because of you! Dont bother coming back to help us."]]

--Mission OSD stuff.

osd = {}
osd[1] = [[Fly to %s and meetup with the main fleet.]]
osd[2] = [[Fly to %s to help attack %s.]]
osd[3] = [[Protect the Marine shuttles, while destroying the opposing fleet.]]
osd[4] = [[Rendevoux with the main fleet on %s in %s.]]

--The following messages are all broadcast in-space.

counter_msg = [[Heads up! A Sirius quick-response fleet just jumped in!]]
shuttles_are_in = [[Get ready! Our marine shuttles have just jumped in! Protect them!]]

brief = {} --Used in the meetsys at the... well... meeting.
brief[1] = "Alright fellas, this is going to get hot quick. We all know our jobs."
brief[2] = "After we've engaged, the shuttles and a couple reinforcements will jump in."
brief[3] = "I can't stress enough, protect them. Also, be expecting a quick reaction force from the Sirius."
brief[4] = "We have to take this station! We have to kill them all! Remember Suna! Remember the slain!"
brief[5] = "For Sirichana! Lets ride!"

function create()

   --This mission attempts to claim both Nougat and Esker.

   if not misn.claim(system.get("Nougat")) and not misn.claim(system.get("Esker")) then  
      tk.msg("Systems not claimed","Systems have already been claimed.")
      misn.finish(false)
   end

   nasin_rep = faction.playerStanding("Nasin")
   misn_tracker = var.peek("heretic_misn_tracker")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01
   homeasset = planet.cur()
   homesystem = system.cur()
   meetsys = system.get("Nougat")
   targetasset,targetsys = planet.get("Fyruse Station")
   endasset,endsys = planet.get("Atalanta")
   jumpchecker = 0
   deathcounter = 0
   shuttles_killed = 0
   
   --set misn stuffs.

   misn.setTitle(misn_title)
   misn.setReward("Reward:" .. reward)
   misn.setNPC(npc_name,"neutral/thief2")
   misn.setDesc(bar_desc)
end

function accept()
    bmsg[1] = bmsg[1]:format(player.name())
    bmsg[4] = bmsg[4]:format(player.name())
    bmsg[6] = bmsg[6]:format(reward)--reward
    bmsg[9] = bmsg[9]:format(meetsys:name(),targetasset:name(),targetsys:name())
    tk.msg(misn_title,bmsg[1])
    tk.msg(misn_title,bmsg[2])
    tk.msg(misn_title,bmsg[3])
    chooser = -1
    while true do
       chooser = tk.choice(misn_title,bmsg[4],convo_choice[1],convo_choice[2],convo_choice[3],convo_choice[4])
        tk.msg(misn_title,bmsg[chooser+4])
	if chooser == 1 then
	   break
	end
	if chooser == 3 then
	   misn.finish(false)
	   break
	end
        if chooser == 4 then --If the player chooses option 4, then the campaign is over.
            var.push("heretic_misn_tracker",-1)
            misn.finish(true)
	    break
        end
    end

    misn.accept()
    misn_desc = misn_desc:format(targetsys:name(),targetasset:name())
    misn.setDesc(misn_desc)
    tk.msg(misn_title,bmsg[9])
    osd[1] = osd[1]:format(meetsys:name())
    osd[2] = osd[2]:format(targetsys:name(),targetasset:name())
    osd[4] = osd[4]:format(endasset:name(),endsys:name())
    misn.osdCreate(misn_title,osd)
    misn.osdActive(1)
    meetthemark = misn.markerAdd(meetsys,"plot")

    hook.jumpin("jumper")

end

function jumper()

--The first if loop is for the initial meet-up with the friendly fleet.

   if system.cur() == meetsys then
      pilot.clear()
      pilot.toggleSpawn("Sirius",false)
      pilot.toggleSpawn("Pirate",false)
      if meetsys_runthrough == nil then
         meetsys_runthrough = 1
         meeting_mark = system.mrkAdd("Nasin Fleet",vec2.new(-500,10000))
	 good_fleet = pilot.add("Nasin Assault Fleet",nil,vec2.new(-500,10000))
	 shuts = pilot.add("Nasin Marine Shuttles",nil,vec2.new(-1000,11000))
	 awes = pilot.add("Nasin Med Defense Fleet",nil,vec2.new(-1100,11100))
	 for i,p in ipairs(awes) do
	    table.insert(shuts,p)
	 end
	 for i,p in ipairs(shuts) do
	    p:control()
	    p:brake()
	    p:setFriendly()
	    p:setVisplayer(true)
	 end
	 for i,p in ipairs(good_fleet) do
	    p:control()
	    p:brake()
	    p:setFriendly()
	    p:setVisplayer(true)
	 end

	 --The hook.date() handles the actual meeting.
	 hook.date(time.create(0,0,100),"proximity",{location=vec2.new(-500,10000),radius=700,funcname="space_meeting"})

	 --The hook.pilot() handles the excess ships that weren't given
	 --explicit instructions to jump.
	 hook.pilot(nil,"jump","time_for_jump")
      end
   end

   --This block of code handles the actual assault in the target system.

   if system.cur() == targetsys then
      mission_status = 1
      pilot.clear()
      pilot.toggleSpawn("Sirius",false)
      pilot.toggleSpawn("Pirate",false)
      enemy = pilot.add("Sirius Defense Fleet",nil,targetasset)
      num_enemy = #enemy
      friend = pilot.add("Nasin Assault Fleet",nil,meetsys)
      for i,p in ipairs(enemy) do
         p:setNoLand()
         p:setNoJump()
         p:setVisible(true)
         p:setHostile(true)
      end
      for i,p in ipairs(friend) do
         p:setVisible(true)
         p:setNoLand()
         p:setNoJump()
         p:setFriendly(true)
      end
      hook.timer(50000,"enter_shuttles")
      hook.timer(75000,"reinforcements")
      hook.pilot(nil,"death","death")
      hook.pilot(nil,"land","ms_land")
   end

   --This bit is for if the player jumps early.

   if mission_status == 1 and system.cur() ~= targetsys then
      tk.msg(misn_title,premature_jump)
      misn.finish(false)
   end
   hook.land("land")
end

function space_meeting()

--This function handles the in-space dialogue after the player meets
--up with the main fleet.
   
   if sm_runthrough == nil then
      if current_time == nil then
	 current_time = time.get()
      end
      if time.get() >= current_time + time.create(0,0,51) and time.get() <= current_time + time.create(0,0,150) and msg_1_check == nil then
	 good_fleet[1]:broadcast(brief[1],false)
         msg_1_check = 1
      elseif time.get() >= current_time + time.create(0,0,151) and time.get() <= current_time + time.create(0,0,250) and msg_2_check == nil then
	 good_fleet[1]:broadcast(brief[2],false)
         msg_2_check = 1
      elseif time.get() >= current_time + time.create(0,0,251) and time.get() <= current_time + time.create(0,0,350) and msg_3_check == nil then
	 good_fleet[1]:broadcast(brief[3],false)
	 msg_3_check = 1
      elseif time.get() >= current_time + time.create(0,0,351) and time.get() <= current_time + time.create(0,0,450) and msg_4_check == nil then
	 good_fleet[1]:broadcast(brief[4],false)
	 msg_4_check = 1
      elseif time.get() >= current_time + time.create(0,0,451) and time.get() <= current_time + time.create(0,0,550) and msg_5_check == nil then
         good_fleet[1]:broadcast(brief[5],false)
	 msg_5_check = 1
         system.mrkRm(meeting_mark)
	 misn.osdActive(2)
	 for i,p in ipairs(good_fleet) do
	    if i == 1 or i == 2 or i == 3 then
	       p:hyperspace(targetsys)
	    elseif good_fleet[math.ceil(i/3)] ~= nil then
               p:follow(good_fleet[math.ceil(i/3)])
	    else
	       p:follow(good_fleet[1])
            end
	 end
	 misn.markerMove(meetthemark,targetsys)
	 sm_runthrough = 1
      end
   end
end

function time_for_jump(p_jumper)

--After the "lead" ships in the meetsys have jumped, the remainder of the
--ships will then be told to jump.

   if p_jumper == good_fleet[1] or p_jumper == good_fleet[2] or p_jumper == good_fleet[3] then
      for i,p in ipairs(good_fleet) do
         if p ~= p_jumper and p:exists() then
	    p:hyperspace(targetsys)
         end
      end
   end
end

function enter_shuttles()

--After a given amount of time in the hook initiated in the jumper function,
--the shuttles jump in and attempt to land on the target asset.

   shuttle = pilot.add("Nasin Marine Shuttles",nil,meetsys)
   landing_check = 0
   num_shuttle = #shuttle
   for i,p in ipairs(shuttle) do
      p:setHilight()
      p:setFriendly()
      p:setVisible(true)
      p:control()
      p:land(targetasset)
   end

   --Shuttles wouldn't be left defenseless in a system by their lonesome.

   ghelp = pilot.add("Nasin Med Defense Fleet",nil,meetsys)
   for i,p in ipairs(ghelp) do
      p:setFriendly()
      p:setVisible(true)
      p:setNoLand(true)
      p:setNoJump(true)
   end
   for _,p in ipairs(friend) do
      if p:exists() and shuttler_check == nil then
        p:broadcast(shuttles_are_in)
        shuttler_check = "check!"
      end
   end
   misn.osdActive(3)
end

function reinforcements()

--After another hook initiated in the main jumper function, a "QRF", or
--quick reaction force, jumps in, attempting to help thwart the Nasin.
--No cap ships, as they aren't fast enough to be responsive.

   enemy2 = pilot.add("Sirius Med Patrol",nil,system.get("Gutter"))
   enemy3 = pilot.add("Sirius Recon Force",nil,system.get("Gutter"))
   for i,p in ipairs(enemy2) do
      table.insert(enemy,p)
      p:setNoLand()
      p:setNoJump()
      p:setHostile()
      p:setVisible(true)
   end
   for i,p in ipairs(enemy3) do
      table.insert(enemy,p)
      p:setNoLand()
      p:setNoJump()
      p:setHostile()
      p:setVisible(true)
   end

   --This bit has a friendly member of the players fleet broadcast a warning.

   for _,p in ipairs(friend) do
     if p:exists() and reinforce_check == nil then
        p:broadcast(counter_msg)
        reinforce_check = "check!"
     end
   end
end

function death(deadpilot)

--This function tracks the deaths of both the Sirius fleet, in regards to
--completing the mission, as well as the amount of shuttles that are still
--alive, in regards to failing the mission.

--First part is for the Sirius.
   faction_check = pilot.faction(deadpilot)
   if misn_finish_check == nil then
      if faction_check == faction.get("Sirius") then
         deathcounter = deathcounter + 1
      end
      if deathcounter == #enemy and reinforce_check == "check!" then
         all_enemy_killed = 1
         returning_time()
      end
   end

--This second part is for the shuttles.
   if shuttle == nil then
      shuttle = {}
   end
   for i,p in ipairs(shuttle) do
      if p == deadpilot then
         shuttles_killed = shuttles_killed + 1
      end
      if shuttles_killed == num_shuttle then
         tk.msg(misn_title,shuttles_all_dead)
         misn.osdDestroy()
         misn.finish(false)
      end
   end
end

function ms_land(landingpilot)

--This function tracks whether or not all of the alive shuttles have landed. 

   for i,p in ipairs(shuttle) do
      if p == landingpilot then
         landing_check = landing_check + 1
         if landing_check == num_shuttle - shuttles_killed then
            tk.msg(misn_title,shuttles_have_docked)
            all_shuttles_landed = 1
            returning_time()
         end
      end
   end
end

function returning_time()

--After the mission objectives have been completed, this function cleans up the
--system and puts in some additional backup.

   if all_enemy_killed == 1 and all_shuttles_landed == 1 then
      mission_status = 2
      misn.osdActive(4)
      misn.markerMove(meetthemark,endsys)
      tk.msg(misn_title,time_to_return)
      bkpfleet1 = pilot.add("Nasin Med Defense Fleet",nil,meetsys)
      bkpfleet2 = pilot.add("Nasin Med Defense Fleet",nil,meetsys)
      bkpfleet3 = pilot.add("Nasin Med Defense Fleet",nil,meetsys)
      for i,p in ipairs(bkpfleet1) do
	 p:setNoLand(true)
	 p:setNoJump(true)
      end
      for i,p in ipairs(bkpfleet2) do
	 p:setNoLand(true)
	 p:setNoJump(true)
      end
      for i,p in ipairs(bkpfleet3) do
	 p:setNoLand(true)
	 p:setNoJump(true)
      end
      for i,p in ipairs(friend) do
	 if p:exists() then
            p:setNoLand(false)
	    p:setNoJump(false)
	    p:control()
	    p:hyperspace(meetsys)
         end
      end
      for i,p in ipairs(ghelp) do
         if p:exists() then
	    p:setNoLand(false)
	    p:setNoJump(false)
         end
      end
   end
end

function land()

   --Handles the end-of-mission.

   if mission_status == 2 and planet.cur() == endasset then
      emsg[1] = emsg[1]:format(endasset:name())
      emsg[4] = emsg[4]:format(player.name())
      tk.msg(misn_title,emsg[1])
      tk.msg(misn_title,emsg[2])
      tk.msg(misn_title,emsg[3])
      tk.msg(misn_title,emsg[4])
      player.pay(reward)
      rep_to_add = 7 - shuttles_killed
      tracker = var.peek("heretic_misn_tracker")
      tracker = tracker + 1
      faction.modPlayer("Nasin",rep_to_add)
      var.push("heretic_system_state",1)
      var.push("heretic_misn_tracker",tracker)
      misn.finish(true)
   elseif mission_status == 1 then
      tk.msg(misn_title,premature_landing)
      misn.finish(false)
   end
end

function abort()
   misn.osdDestroy()
   misn.finish(false)
end

