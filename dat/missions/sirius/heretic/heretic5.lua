--[[misn title - the shutdown]]
--[[in this mission, the nasin are back, and are requesting the players help. only this time around, they are on the offense. seriously. this "chapter" is going to be a lot more combat oriented than the first, including large scale battles between house sirius and the nasin heretics, who arent playing nice, even with civilian populations. think terrorism.  this mission starts out as a scouting run for an impending invasion force. emphasis here is more on speed and stealth.
Draga, the players handler and key point of contact with the nasin, died in the last mission of the Prologue from Sirius infiltrators, and now we get into the meat of characters.
Clase Homons - The overseer of the section that the player will be working in during this chapter. Skrat is a colonel of sorts, as the player is inducted into the militia.
Jimmy Thomorr - A "recruiter" with the nasin, who is there to talk the player into joining.
Mase Attes - The players commander.
Marton Heson - A pilot who flies with the player, and offers advice.]]


--[[todo
      ]]
include("proximity.lua")

lang = naev.lang()
misn_title = "The Shutdown"
bmsg = {}
bmsg[1] = [[You walk up to the two serious looking men, wondering why you are even approaching. Thats when you realize that you know the one on the left. Jimmy, the one whom you had met when you landed on Ulios with all the Nasin refugees. Upon seeing you approach, they motion for you to sit down. The one on the left, Jimmy, begins the conversation. "%s! It is good to finally get to sit down with you. My name is Jimmy Thomorr, in case you had forgotten, and this is Mase Attes, and we are fortunate members of the Nasin. We are very glad to have you come and join us."]] --playername
bmsg[2] = [[Thomorr guestures for you to sit down. "When the Sirius launched their attack on our assets and churches, we suffered greatly. They didn't even stop at the men. They imprisoned women, children, even the elderly. Any one resisting was shot. They even went as far as to attempt undercover operations on all of our locations they knew about outside of their space. They nearly wiped us out, but we survived. We have several major centers operating now, and things are looking up. We've been activily recruiting, not hiding in the dark, and we feel it is time to strike back against those oppresive tyrants."]]
bmsg[3] = [[Mase Attes pulls out a binder, and opens it. "This is a rough idea of what we've had going on in our navy since the attack." He points out some figures and a couple graphs, and begins to explain. "The Nasin really had no true organized navy prior to the attack on The Wringer, as we had no reason. We had a roughly hewn, disorganized militia. After the attack, we decided we wanted revenge. We needed revenge. So our leadership decided that we needed a true navy, and began hiring pilots from amongst our ranks, as well as buying up any and all combat worthy vessels to equip those pilots with."]]
bmsg[4] = [[Thomorr, at this point, coughs and interupts Attes' monologue. "Where you come in, %s, is that we need you. You are a decent pilot, and you already own a good vessel. Our navy... suffered... during the Sirius attack, and we are looking for a few good pilots to help our navy out. We can't guarantee you anything, but we can offer you prestige, honor, and a few credits. As well as a chance to take out some Sirius. We want you in the Nasin Navy. What do you say?]] --playername
convo_choice = {
   "I say yes!", --[[links to bmsg[5],[9]]]
   "How much pay are we talking?", --[[links to bmsg[6]]]
   "Give me some time to think about it.",--[[links to bmsg[7]]]
   "I don't want any part in this heresy!"--[[links to bmsg[8]]]
   }
bmsg[5] = [[Attes smiles broadly. "Good. Good. Well, you will be working closely with me, as I will be your immediate commander. I'm glad to have you on board." He shakes your hand enthusiastically. "I have a current wing under me of about 6 ships. You will be flying with us. The fleet is about 18 ships."]]
bmsg[6] = [[Thomorr shakes his head and gives Attes an "I told you he was about the money" look. He turns to you. "We will pay, and promote you, based on your loyalty to us and your performance. It will be on a per-mission basis. Base pay is 10,000 credits from here on forward. Of course, this is only the base pay. You'll be making much more. This mission, we will pay you %d."]] --reward
bmsg[7] = [[Thomorr and Attes both rise and shake your hand. Thomorr speaks, "Please, take your time. We will be hanging around here if you wish to come back."]]
bmsg[8] = [[Thomorr rises and anger, and Attes reaches over the table and lands a right hook on your jaw. You topple over backwards, and by the time you rise up, they've already stormed off. Your glad to be done with this.]]
bmsg[9] = [[Attes seems quite happy at the moment, and he continues. "Well, we do have a current mission to go on. The Nasin are beginning our retaliation on House Sirius, and we are issuing a coordinated attack on about 10 outlying military installations. More guerilla warfare, mind you. We want to cause chaos. You will be meeting up with the fleet in %s, and attacking %s in %s. You were the last piece of the puzzle. Now, get going!"]] --meetsys, target asset, target system
emsg = {}
emsg[1] = [[You land on %s, grateful to have made it out of the mission alive. These Nasin were getting serious, and the Sirius are getting angry. You land in the hanger and step out of your ship, to be greeted by Mase Attes. He was grinning ear to ear, obviously quite happy at the success of the assault. He claps you on the shoulder, and the two of you begin walking towards the rear of the hanger together. He begins to speak.
"I'm glad you made it out of there. I would hate to have your first mission for me end in your ship getting blown up! It would've looked back for the fleet. That stuff should only happen with those crazy special forces guys." He shakes his head.]] --homeasset
emsg[2] = [[As though thinking of some grand, new idea, he looks to you with a gleam in his eye. "You know, our special forces just recently formed with our push towards militism. If your performance is good enough under me, I can tell Thomorr to put in a good word for you over there. Crazy stuff, those kids. I've heard rumours of deep interception missions, hunting and assassinating high-ranking officials, and other things that have a high mortality rate. I'm sure they'd love to have a crazy kid like you!"]]
emsg[3] = [[You and Attes reach the back of the hanger, and turn around. You and him survey the myriad of ships in the hanger, both taking off and landing. "You did good out there, %s. I'm glad to have you on board. You should know, your in now. We appreciate your dedication and loyalty." He coughs. "We are planning another assault. Come and meet me in the bar when your ready to take down another Sirius asset. Payment for this mission has already been credited to your account." With this, he shakes your hand gratefully and strides out, leaving you alone at the back of the hanger.]] --playername
npc_name = "Thomorr and Attes"
bar_desc = "You see two men, chatting at one of the tables against the wall."
counter_msg = [[Heads up! A Sirius counter-attack fleet just jumped in!]]
shuttles_are_in = [[Get ready! Our marine shuttles have just jumped in! Protect them!]]
time_to_return = [[Your comm squaks, a little bit of post-jammer feedback giving you a start. The fleet commanders voice drifts into the static, addressing what remains of the fleet. "Good job boys! The Sirius are all dead, and you guys are cleared to come on home. Drinks are on me!"]]
shuttles_all_dead = [[You see a flash as the last shuttle explodes. You comm squeals to life, and the voice of Attes blares to life. "Alright guys, you gave it a good run. The shuttles are all gone so this mission is a failure. Get back to base if you can, we are sounding the retreat." The static cuts out.]]
shuttles_have_docked = [[The comm station blinks to life, and you see one of the commanders of the marine shuttles. He is broadcasting to all the Nasin ships in the area. "We have all the shuttles landed, and are currently taking command of the station. Resistance is light, we dont expect to much trouble. Thanks for the cover!" The comm channel closes, leaving the ship in silence again.]]
premature_jump = [[You flash out of hyperspace, and almost immediately your comm stations priority channel comes to life. You hear the angry voice of Attes. "You jumped out of the system too early! Thanks for nothing. Get lost kid!"]]
premature_land = [[As soon as you enter the atmosphere, your priority communication channel bleeps, and Attes fills the cabin with his sonorous voice. "We requested that you not land until the mission is complete. The shuttles and your fleet-mates are at risk because of you! Dont bother coming back to help us."]]
osd = {}
osd[1] = [[Fly to %s and meetup with the main fleet.]]
osd[2] = [[Fly to %s to help attack %s.]]
osd[3] = [[Protect the Marine shuttles, while destroying the opposing fleet.]]
osd[4] = [[Rendevoux with the main fleet on %s in %s]]


function create()

   --set variables
   nasin_rep = faction.playerStanding("Nasin")
   misn_tracker = var.peek("heretic_misn_tracker")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01
   homeasset = planet.cur()
   homesystem = system.cur()
   meetsys = system.get("Nougat")
   targetasset,targetsys = planet.get("Fyruse Station")
   jumpchecker = 0
   deathcounter = 0
   shuttles_killed = 0
   shuttle = {} --declaring an empty table to avoid errors in the assault.
   
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
    bmsg[9] = bmsg[9]:format(meetsys:name(),targetasset:name(),targetsys:name())--meetsys, target asset, target system
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
        if chooser == 4 then
            var.push("heretic_misn_tracker",-1)
            misn.finish(true)
	    break
        end
    end
    misn.accept()
    tk.msg(misn_title,bmsg[9])
    osd[1] = osd[1]:format(meetsys:name())
    osd[2] = osd[2]:format(targetasset:name(),targetsys:name())
    osd[4] = osd[4]:format(homeasset:name(),homesystem:name())
    misn.osdCreate(misn_title,osd)
    misn.osdActive(1)
    meetthemark = misn.markerAdd(meetsys,"plot")
    hook.jumpin("jumper")
end

function jumper()
   if system.cur() == meetsys then
      pilot.toggleSpawn("Sirius",false)
      good_fleet = pilot.add("Nasin Assault Fleet",nil,vec2.new(-500,10000))
      pilot.add("Nasin Marine Shuttles",nil,vec2.new(-1000,11000))
      for i,pilot in ipairs(good_fleet) do
         pilot:control()
         pilot:brake()
         pilot:setFriendly()
      end
      hook.timer(400,"proximity",{location=vec2.new(-500,10000),radius=300,funcname="space_meeting"})
   end
   if system.cur() == targetsys then
      mission_status = 1
      pilot.clear()
      pilot.toggleSpawn("Sirius",false)
      enemy = pilot.add("Sirius Defense Fleet",nil,targetasset)
      num_enemy = #enemy
      friend = pilot.add("Nasin Assault Fleet",nil,meetsys)
      for i,p in ipairs(enemy) do
         p:setNoLand()
         p:setNoJump()
      end
      for i,p in ipairs(friend) do
         p:setNoLand()
         p:setNoJump()
      end
      hook.timer(30000,"enter_shuttles")
      hook.timer(120000,"reinforcements")
      hook.pilot(nil,"death","death")
      hook.pilot(nil,"land","ms_land")
   end
   if mission_status == 1 and system.cur() ~= targetsys then
      tk.msg(misn_title,premature_jump)
      misn.finish(false)
   end
end

function space_meeting() --for meeting the friendly fleet in the meetup system
   current_time = time.get()
   while true do
      if time.get() == current_time+time.create(0,0,5) then
         good_fleet[1]:broadcast(brief[1],false)
      elseif time.get() == current_time+time.create(0,0,10) then
         good_fleet[1]:broadcast(brief[2],false)
      elseif time.get() == current_time+time.create(0,0,15) then
         good_fleet[1]:broadcast(brief[3],false)
      elseif time.get() == current_time+time.create(0,0,20) then
         good_fleet[1]:broadcast(brief[4],false)
      elseif time.get() == current_time+time.create(0,0,21) then
         misn.osdActive(2)
         for i,pilot in ipairs(good_fleet) do
            if i == 1 then
               pilot:hyperspace(targetsys)
            else
               pilot:follow(good_fleet[i-1])
            end
         end
         break
      end
   end
   misn.markerMove(meetthemark,targetsys)
end

function enter_shuttles()
   shuttle = pilot.add("Nasin Marine Shuttles",nil,meetsys)
   num_shuttle = #shuttle
   for i,p in ipairs(shuttle) do
      p:setHilight()
      p:control()
      p:land(targetasset)
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
   enemy2 = pilot.add("Sirius Defense Fleet")
   for i,p in ipairs(enemy2) do
      table.insert(enemy,p)
      p:setNoLand()
      p:setNoJump()
   end
   for _,p in ipairs(friend) do
     if p:exists() and reinforce_check == nil then
        p:broadcast(counter_msg)
        reinforce_check = "check!"
     end
   end
   num_enemy = #enemy
end

function death(deadpilot) --track sirius deaths and shuttle deaths
   faction_check = pilot.faction(deadpilot)
   if misn_finish_check == nil then
      if faction_check == faction.get("Sirius") then
         deathcounter = deathcounter + 1
      end
      if deathcounter == num_enemy then
         mission_status = 2
         misn.osdActive(4)
	 misn.markerMove(meetthemark,homesystem)
         tk.msg(misn_title,time_to_return)
      end
   end
   for i,pilot in ipairs(shuttle) do
      if pilot == deadpilot then
         shuttles_killed = shuttles_killed + 1
      end
      if shuttles_killed == num_shuttle then
         tk.msg(misn_title,shuttles_all_dead)
         misn.osdDestroy()
         misn.finish(false)
      end
   end
end

function ms_land(landingpilot) --when the shuttles land
   for i,pilot in ipairs(shuttle) do
      if pilot == landing and landing_check == num_shuttle - shuttles_killed then
         tk.msg(misn_title,shuttles_have_docked)
      end
   end
end

function land() --when the player lands
   if mission_status == 2 and planet.cur() == homeasset then
      emsg[1] = emsg[1]:format(homeasset:name())
      emsg[3] = emsg[3]:format(player.name())
      tk.msg(misn_title,emsg[1])
      tk.msg(misn_title,emsg[2])
      tk.msg(misn_title,emsg[3])
      player.pay(reward)
      rep_to_add = 7 - shuttles_killed
      tracker = var.peek("heretic_misn_tracker")
      tracker = tracker + 1
      faction.modPlayer("Nasin",rep_to_add)
      --~ var.push("heretic_misn_tracker",tracker)   --holding off on this until mission is finished.
      misn.finish(true)
   elseif mission_status == 1 then
      tk.msg(misn_title,premature_landing)
      misn.finish(false)
   end
end

function abort() --when it gets aborted
   misn.osdDestroy()
   misn.finish(false)
end

