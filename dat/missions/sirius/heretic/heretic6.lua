--[[misn title - the aggressor]]
--[[this mission is much like its predecessor, the showdown, in that it involves a conflict between the nasin navy and the sirius navy. the nasin are trying to take another asset, and the sirius are trying to stop them. because one large fleet battle is never enough. the nasin, in the prior episode, had several military actions happening simultaneously. the player participated in one of these actions. in this one, more pushes are being made, and the sirius are being driven back even more.]]

include("proximity.lua")

lang = naev.lang()
misn_title = [[The Aggressor]]

--Opening dialogue.
bmsg = {}
bmsg[1] = [[You approach Mase Attes, who is sitting at a table with two other men. Attes rises upon seeing you and shakes your hand. "Good to see you, %s! I hope Sirichana smiles upon you in your latest travels." He sits back down, and guestures for you to do the same. "%s, please let me introduce you to Clase Homons, and Marton Heson." Clase, sitting to Attes' left, is a shorter, dumpier man. He is slightly balding, and looks past his prime. A glint in his eye, however, indicates that it may be technologically enhanced, and the peculiar way his muscles bulge remind you of some holovids of Soromid genetic enhancements. Marton is the opposite of Homons, young and musculur. He is the picture of health, included with a full head of hair and a beard that needed to be trimmed a couple days ago. They both lean across the table in turn, and shake your hand.]]  --playername, playername.
bmsg[2] = [[Attes retakes control of the situation, and flips some holo paper at you. You see strategies, and attack plans, for a yet-unmarked Sirius asset. "%s, Homons is the fleet overseer of this part of the operation, and Heson flies with you. We were just discussing strategy. The momentum gained with the previous assaults needs to be capitalized upon, and we are looking at other systems to attack." At this point, Homons interjects. "Attes is correct. We are going to be assaulting  %s, specifically the stronghold in %s. With our previous assault, we had the element of suprise. We struck swiftly and quickly. Now, House Sirius has had time to prepare, and they've reinforced high value assets and systems as quickly as they could. We are expecting much more resistance." Homons takes a drink from the glass in front of him.]] --playername, targetsystem, targetasset.
bmsg[3] = [[With Homons in a pause, Marton Heson feels it is his time to add to the conversation. "Thing is, due to the reinforcements, we need a little more finess than just a punch and drive. We are expecting three Sirius fleets to be in-system; here, here, and here." He points to several places on the holo paper, which had been marked with several large red Os. "We are having the 7th fleet fly in to help us out." At this point, Marton mumbles under his breath, "not that the 9th fleet needs any help." He continues mumbling, but Attes cuts him gracefully off. "9th fleet, us, we will be in charge of making sure the shuttles make it to the station. The shuttles will be jumping in with you. We've already spread the word to the other pilots, do you think this is something that you can handle?"]]
bmsg[4] = [[Attes, Homons, and Heson all pause, and give you a chance to respond.]]
--the following section is for "Why not attack somewhere else?"
bmsg[5] = [[Homons clears his thoat. "Obelisk Station poses a serious threat to our advancing forward any farther. As such, it is a priority target. Also, securing Scarlet, Valor Gem, and Druss will allow us to connect with 2nd, 4th, and 8th fleets, who are pressing forward from the south. This will give us a more unified front. Also, 7th fleet just secured Gutter, and we need to protect our rear-end." Homons leans back in his chair, content with his justification of his choice. He has obviously thought a lot about this.]]
--the following section is for "What are the Sirius fleets up to?"
bmsg[6] = [[Attes leans forward, signaling to the other two that he is going to answer this question. "Quite frankly, we don't know. We aren't experiencing as much pushback as would be expected, especially here and up north with 3rd fleet. We think they are holding back, but for what reason we don't know. Maybe sacrificing the outlying systems to secure the more important systems deeper in the sector? All our theories and answers are pure conjecture. We are sending in recon elements, but so far none of them have returned." Homons looks worried, and Heson looks angry. Heson looks at Attes. "You could send me and a couple boys in to take a look. I'd get it done no problem." Attes looks at him, frustrated. "You are too valuable, Heson. We've been over this before." Heson looks defeated, and like he's been defeated about this point before.]]
--The following section is for "What are the Nasin fleets up to?"
bmsg[7] = [[Homons pulls the holo paper over to him, and inputs a few commands. He passes it back, and it shows a large map of the Sirius territory. He guestures to various green circles as he talks."Well, 9th fleet and 7th fleet here just secured Esker, and 7th fleet pushed on and took Gutter. 2nd, 4th, and 8th fleets took Eye of Night, and 2nd is moving south, while 4th and 8th push north trying to connect with us. 3rd fleet and 11th fleet took Pike, and 3rd is pushing forward to Neon while 11th swings around to Kraft. 6th fleet is having some trouble there taking it. They've been rebutted twice, and reinforcements are flown in constantly. Once Neon is taken, 5th fleet can move into Kraft from the opposite direction and hammer them hard while 3rd continues to hold Neon. The Northern fleets are prioritized with pressing hard to Aesir, while we are to apply pressure to the abbundance of military assets to the south." Homons pulls the paper back and clears it for further use.]]
--The following section is for "Money talks. How much are you offering?"
bmsg[8] = [[Heson casts a glance at Attes, and then Homons. "The money doesn't matter. What does matter is taking care of business, and raising a glorious new religion free from the oppressive rule of the corrupt! We need your loyalty, %s, free from greed, especially if I'm expected to fly by your side." Attes nods approvingly at Heson, and then turns to you. "As usual, %s, we will pay you what we agreed upon. %d. If that isn't good enough for you, then I apologize, but its what we think your worth right now." Attes looks upset, and Homons glares at you. Maybe you shouldn't have asked. They apparently don't like talking about money.]] --playername, playername, reward
--The following section is for "I'm in. Lets do this."
bmsg[9] = [[Heson claps his hands once. "Great! We have a briefing we need to get to. You were late to the party last time and got miss out. Not that I'm jealous or anything." He turns to Attes and Homons, and says as he stands up, "Attes, we should get going. Homons, as usual it was good to see you. I hope we meet again under such favourable circumstances." He winked at Homons, and he and Attes led you out of the bar.]]
bmsg[10] = [[Heson and Attes led you to a small side room, off the back of one of the hangers. Once inside, you see that the small room is filled with a wealth of people. Attes weaves his way to the other end of the room, where the is a raised dias, and Heson explains things to you. "These are all the pilots you fly with. That big guy over there," he points to a richly dressed fat man in blue, "is the captain of one of the Kestrels. Word is, he helped design the weapons cooling system, so his is somehow supped up and amazing. And those two," he now points at a couple, who are lounging around in the back chatting idly, "are Marck and Qate, who pilot a couple Admonishers. Amazing pilots, all of them. So, now Attes is going to go tell us how we are going to go about assaulting our next target." Attes, timing it perfectly with Hesons monologue to you, clears his throat and the room falls silent.]]
bmsg[11] = [[Attes looks everyone over, giving a moment for the silence to set in. "Alright, ladies and gents, first off, Homons sends his gratitude and congratulations for a job well done on our last mission." A couple whoops from around the room give rise to a little laughter. "You all did a fine job, and I am glad you returned home. Those that didn't... well, they will be missed. I will never forget them." Attes pauses for another silent moment, to emphasis this point. "As some of you may have heard, our next assault will be on %s. Our over-arching goal here is to meet up with 4th fleet, who is pushing north towards us as we speak. When we connect with them, there will be a unified front between 2nd fleet, 4th fleet, 7th fleet, 8th fleet and the glorious 9th fleet!" Attes pumps his fist into the air, and small cheers erupt from the gather pilots.]] --targetsystem
bmsg[12] = [[Attes continues. "But now, for some more business!" The lights flick out, and a holovid appears in the middle of the room, showing a map of the system. "We will be jumping in from this point here, and our primary objective is to be taking %s. It is the military stronghold in this sector, so don't expect this to go easy. The shuttles will be, I repeat, will be jumping in with us. We need to protect them, and they can take care of stuff when they land. They have some crazy stuff planned for that station. They will be beelining for the station, so we just need to hold off their forces. After we jump in, 7th fleet will follow us shortly. They are tasked with obtaining control of any other assets. We expect all the other assets to be more minor, so their marines will have an easier time. Things to keep in mind: We jump first, so we take the biggest hit. 7th fleet will help us out, but they'll be a long time coming. Also, after we are done, we will be landing on %s to regroup. We will be taking off quickly, word is Overwatch Command has a special assignment for us." More hoots and jeers.]] --targetasset, targetasset.
bmsg[13] = [[Attes smiles at everyone. "Alright people, in a nutshell. Fly to %s. Kick some butt. Take some names. Regroup on %s. Sound good?" Nods bobbed heads up and down here and there. "Alright! Lets do this! We will meet above %s in %s, so hurry up!" The small group cheers, and then slowly files out of their room to make final preps before taking off. You follow their lead, and begin prepping yourself.]] --meetasset, meetsys
--The following section is for "Let me think about this." 
bmsg[14] = [[The three men sitting around the table look suprised at this statement. Homons is the first to recover, and he begins to speak. "Well, I guess thats fine. Just please understand the urgency of the situation, and hurry back here to us. House Sirius won't wait forever. May Sirichana be with you." At that, he guestured to the other two men, and they got up together and walked out of the bar.]]

--Ending messages

emsg = {}
emsg[1] = [[You land on %s with the other Nasin pilots, as ordered. Upon docking, you enter a large chamber. You can hear gunfire echoing in the distance. Obviously the fighting to take over this station is not over yet. You walk up to join a gathering crowd of pilots. You see Homons, who motions you over to join him. "That was pretty crazy stuff!" He starts speaking rapidly, still on an adrenaline rush after all the prior fighting. "I had like four fighters on my rump when Seventh Fleet jumped in. I was getting worried they were going to miss the party! Dang they cut it close." Homons shakes his head, and you hear someone clearing his throat in the middle of the group. A large explosion echoes dimly in the distance, as Attes begins to speak. "Ladies and gentlemen, good job! Seventh Fleet is currently tasked with maintaining the control of this system. Normally we'd be up there with them but..." Here he stopped for dramatic effect, probably pausing longer than necessary, "Ops Command has a special assignment for us!" Whoops and jeers filled the chamber.]] --targetasset
emsg[2] = [[Some nearby cracks from a mass rifle had a few pilots ducking their heads. One pilot spoke up. "Hey, Attes, are the Marines going to be able to take this thing?" Attes looked at him and nodded. "Latest reports show we outnumber them three to one, and we currently have possesion of 65% of the station, including 80% of most major substations. We have this in the bag. Now, for our assignment! The enemy has holed up in a certain system of their space, and we've been tasked to deal the death blow." Another explosion rocked the space, and at this, Attes began to look a little worried, despite his previous re-assurance. He cocked his ear to one side, listening to an cochlear implant. "Bad news, gents. The Sirius have apparently bugged and booby-trapped the whole station. Meet up with your wing commanders in the bar, and they will brief you there. I have received word that they have set up isolation bubbles just for our use. Get going, as time is of the essense! You are dismissed!" Attes shouts these last words, and the group slowly disbands, some shuffling to their ships to see about post-combat damage repairs, others heading to the bar to get a drink while they wait for the briefings to start.]]

--Convo choices

convo_c = {}
convo_c[1] = [[Why not attack somewhere else?]]
convo_c[2] = [[What are the Sirius fleets up to?]]
convo_c[3] = [[What are the Nasin fleets up to?]]
convo_c[4] = [[Money talks. How much are you offering?]]
convo_c[5] = [[I'm in. Lets do this.]]
convo_c[6] = [[Let me think about this. I'll be right back.]]

--Messages used in the space_meeting function.

brief = {}
brief[1] = [[Glad to have you all back. This is gonna be heavier than last time.]]
brief[2] = [[Remember, get the shuttles to the station. This is priority one.]]
brief[3] = [[If you try and jump out-sys or land prematurely I'll shoot you myself, so don't do it.]]
brief[4] = [[Obelisk Station doesn't stand a chance. Lets destroy them!]]
brief[5] = [[Let's do this!]]

--In flight messages to be used during the assault.

ifm = {}
ifm[1] = [[7th fleet has arrived with their shuttles! Watch their backs too!]]
ifm[2] = [[A Sirius response fleet has just jumped in. Watch yourself!]]
ifm[3] = [[A shuttle just got destroyed! There are only %d left! Guard them with your life!]] --#shuts
ifm[4] = [[Some more Nasin backup just jumped in!]]
ifm[5] = [[Great job guys! Lets head to %s to debrief!]]

--Message for the Nasin pilots to say after killing some baddies.

kilb = {}
kilb[1] = [[Got one!]]
kilb[2] = [[Tango down, acquiring new target.]]
kilb[3] = [[For Sirichana!!]]
kilb[4] = [[Here's Johnny!]]
kilb[5] = [[Well that takes care of that.]]
kilb[6] = [[One more soul for the judgement hand of Sirichana.]]
kilb[7] = [[All glory to Sirichana!]]
kilb[8] = [[And another soul perishes.]]
kilb[9] = [[Untouchable!]]
kilb[10] = [[Mark one more dead.]]

--Random descriptions

bar_desc = [[You see Attes sitting with two men you haven't seen before. They're sitting around a table chatting.]]
npc_name = [[Attes]]
misn_desc =[[Assault %s, while protecting the marine shuttles. 7th fleet will be jumping in to help.]] --targetsys
shuttles_have_docked = [[Your comm station blares to life, and you see a commander for one of the shuttles pop up. "Hey! Thanks for the escort! We've touched down, and are breaching main sections of the station now. We are good to go!" The comm station goes quiet once again.]]
shuttles_have_died = [[Your priority comm channel opens pretty much as soon as the last piece of Sirius ordinance rips through the final shuttle. Attes' voice fills your cabin, "The shuttles are all gone boys. Fall back, and we will regroup and come up with something else. Thanks, boys." The channel cuts out, and an awkward silence fills the space, before several flashes remind you that even though the shuttles have died and the mission is over, you are still surrounded by hostile Sirius.]]

--Mission OSD

osd = {}
osd[1] = [[Fly to %s and meetup with the main fleet over %s.]] --meetsys, meetasset
osd[2] = [[Fly to %s to help assault %s.]]
osd[3] = [[Take out the opposing Sirius fleet, while guarding the shuttles.]] --targetsys, target asset
osd[4] = [[Rendevoux with the main fleet on %s in %s.]] --targetasset,targetsys


function create()
   
   --This mission attempts to claim Scarlet and Esker

   targetasset,targetsys = planet.get("Obelisk Station")
   sectarget = planet.get("Burnan")
   meetasset,meetsys = planet.get("Esker II")

   if not misn.claim({targetsys,meetsys}) then
      misn.finish(false)
   end
   
   misn.setNPC(npc_name,"neutral/thief1")
   misn.setDesc(bar_desc)

end



function accept()

--Set some variables.

   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

--Opening dialogue.

   bmsg[1] = bmsg[1]:format(player.name(),player.name())
   bmsg[2] = bmsg[2]:format(player.name(),targetsys:name(),targetasset:name())
   bmsg[8] = bmsg[8]:format(player.name(),player.name(),reward)
   bmsg[11] = bmsg[11]:format(targetsys:name())
   bmsg[12] = bmsg[12]:format(targetasset:name(),targetasset:name())
   bmsg[13] = bmsg[13]:format(targetasset:name(),targetasset:name(),meetasset:name(),meetsys:name())
   tk.msg(misn_title,bmsg[1])
   tk.msg(misn_title,bmsg[2])
   tk.msg(misn_title,bmsg[3])
   while true do
      talk = tk.choice(misn_title,bmsg[4],convo_c[1],convo_c[2],convo_c[3],convo_c[4],convo_c[5],convo_c[6])
      if talk ~= 5 and talk ~= 6 then
	 tk.msg(misn_title,bmsg[talk+4])
      elseif talk == 5 then
	 for i = 1,5 do
	    v = i + 8
	    tk.msg(misn_title,bmsg[v])
	 end
	 break
      elseif talk == 6 then
	 tk.msg(misn_title,bmsg[14])
	 misn.finish(false)
	 break
      end
   end

   misn.accept()

--Set up the OSD.

   creatingTheOsd()
   misn.osdCreate(misn_title,osd)
   misn.osdActive(1)

--Set mission variables
   
   misn_desc = misn_desc:format(targetsys:name())
   misn.setDesc(misn_desc)
   misn.setTitle(misn_title)
   misn.setReward("Reward: " .. reward)
   
--Mark the meet system.

   meetthemark = misn.markerAdd(meetsys,"plot")

--Inital hook.

   hook.jumpin("jumper")

end

function creatingTheOsd()

   osd[1] = osd[1]:format(meetsys:name(),meetasset:name())
   osd[2] = osd[2]:format(targetsys:name(),targetasset:name())
   osd[3] = osd[3]:format(targetasset:name(),targetsys:name())
   osd[4] = osd[4]:format(targetasset:name(),targetsys:name())

end

function updatingTheOsd()
   
   misn.osdDestroy()
   creatingTheOsd()
   osd[3] = [[Take out the opposing Sirius fleet, while guarding the shuttles. There are %d out of %d shuttles left alive.]] --aliveshuts,#shuts
   osd[3] = osd[3]:format(#shuts,#shuts)
   misn.osdCreate(misn_title,osd)
   misn.osdActive(3)

end

function jumper()

--The first if loop is for the initial meet-up with the friendly fleet.

   if system.cur() == meetsys then
      pilot.clear()
      pilot.toggleSpawn("Pirate",false)
      pilot.toggleSpawn("Sirius",false)
      if meetsys_runthrough == nil then
         meeting_mark = system.mrkAdd("Nasin Fleet",meetasset:pos())
	 good_fleet = pilot.add("Nasin Assault Fleet",nil,meetasset:pos())
	 shuts = pilot.add("Nasin Marine Shuttles",nil,meetasset:pos())
	 for i,p in ipairs(shuts) do
	    p:control(true)
	    p:brake(true)
	    p:setFriendly(true)
	    p:setVisplayer(true)
	 end
	 for i,pil in ipairs(good_fleet) do
	    pil:control(true)
	    pil:brake(true)
	    pil:setFriendly(true)
	    pil:setVisplayer(true)
	 end
      end

--The hook.date() handles the actual meeting.

      hook.date(time.create(0,0,100),"proximity",{location=meetasset:pos(),radius=700,funcname="space_meeting"})

--The hook.pilot() handles the excess ships that weren't given
--explicit instructions to jump.

      hook.pilot(nil,"jump","time_for_jump")
   end

--This block of code handles the actual assault in the target system.

   if system.cur() == targetsys and meetsys_runthrough ~= nil then
      mission_status = 1
      sys_planets = system.planets(system.cur())
      pilot.clear()
      pilot.toggleSpawn("Sirius",false)
      pilot.toggleSpawn("Pirate",false)
      enemy = pilot.add("Sirius Defense Fleet",nil,(targetasset:pos()+sectarget:pos()/2))
      enemy1 = pilot.add("Sirius Defense Fleet",nil,vec2.new(rnd.rnd(-1000,-8000),rnd.rnd(-1000,-8000)))
 
      --Set up the OSD.
      updatingTheOsd()

      for i,p in ipairs(enemy1) do
	 table.insert(enemy,p)
      end
      for i,p in ipairs(enemy) do
         p:setNoLand()
         p:setNoJump()
         p:setVisible(true)
         p:setHostile(true)
      end

      friend = pilot.add("Nasin Assault Fleet",nil,meetsys)
      shuts = pilot.add("Nasin Marine Shuttles",nil,meetsys)
      for i,p in ipairs(friend) do
         p:setVisible(true)
         p:setNoLand()
         p:setNoJump()
         p:setFriendly(true)
      end
      for i,p in ipairs(shuts) do
	 p:setVisible(true)
	 p:control(true)
	 p:land(targetasset)
	 p:setFriendly(true)
	 p:setHilight(true)
      end

      hook.timer(40000,"nasinBackup")
      hook.timer(115000,"siriusBackup")
      hook.timer(140000,"nasinMoreBackup")
      hook.pilot(nil,"death","death")
      hook.pilot(nil,"land","ms_land")
   end

   --This bit is for if the player jumps early.

   if mission_status == 1 and system.cur() ~= targetsys then
      abort()
   end
   hook.land("land")
end


function nasinBackup()

   --This jumps in another fleet, which is supposed to help the players fleet. Their main obj is Burnan, but we'll see how that works.

   --Initialize the fleets.

   friendBkup = pilot.add("Nasin Assault Fleet",nil,meetsys)
   shutsBkup = pilot.add("Nasin Marine Shuttles",nil,meetsys)

   --Set up the fleets right.
   for i,p in ipairs(friendBkup) do
      p:setVisible(true)
      p:setFriendly(true)
      p:setNoLand(true)
      p:setNoJump(true)
      table.insert(friend,p)
   end
   for i,p in ipairs(shutsBkup) do
      p:control()
      p:setVisible(true)
      p:setFriendly(true)
      p:land(sectarget)
      p:setHilight(true)
      table.insert(shuts,p)  
   end

   --Let the player know about this new development.
   
   msg_check = nil
   for i,p in ipairs(friend) do
      if p:exists() and msg_check == nil then
	 p:broadcast(ifm[1])
	 msg_check = "check!"
      end
   end
   
   --Redo the OSD
   updatingTheOsd()


end

function nasinMoreBackup()

   --Just to even the odds a little more.

   --initialize!

   moreBackup = pilot.add("Nasin Med Defense Fleet",nil,meetsys)
  
   --set up correctly.

   for i,p in ipairs(moreBackup) do
      p:setNoJump(true)
      p:setNoLand(true)
      p:setVisible(true)
      p:setFriendly(true)
      table.insert(friend,p)
   end

   --Let the player know.
   msg_check = nil
   for i,p in ipairs(friend) do
      if p:exists() and msg_check == nil then
	 p:broadcast(ifm[4],true)
	 msg_check = "check!"
      end
   end

end

function siriusBackup()

   --Jumps in a Sirius response fleet.

   enemy_r = pilot.add("Sirius Defense Fleet",nil,system.get("Valur Gem"))
   for i,p in ipairs(enemy_r) do
      table.insert(enemy,p)
      p:setHostile(true)
      p:setVisible(true)
      p:setNoLand(true)
      p:setNoJump(true)
   end
   reinforce_check = "check!"
   --Let the player know.

   msg_check = nil
   for i,p in ipairs(friend) do 
      if p:exists() and msg_check == nil then
	 p:broadcast(ifm[2],true)
	 msg_check = "check!"
      end
   end

end

function space_meeting()

   --This function handles the in-space dialogue after the player
   --meets up with the main fleet.
   
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
	 meetsys_runthrough = 1
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
	 for i,p in ipairs(shuts) do
	    if followCheck == nil then
	       p:follow(good_fleet[1])
	       followCheck = "following!"
	    else
	       p:follow(shuts[i-1])
	    end
	 end
	 misn.markerMove(meetthemark,targetsys)
	 sm_runthrough = 1
      end
   end
end

function time_for_jump(p_jumper)

   --After the "lead" ships in the meetsys have jumped, the remainder
   --ships will then be told to jump.

   if p_jumper == good_fleet[1] or p_jumper == good_fleet[2] or p_jumper == good_fleet[3] then
      for i,p in ipairs(good_fleet) do
         if p ~= p_jumper and p:exists() then
	    p:hyperspace(targetsys)
         end
      end
      for i,p in ipairs(shuts) do
	 p:hyperspace(targetsys)
      end
   end
end

function death(deadpilot,killer)

   --This function tracks the deaths of both the Sirius fleet, in regards to
   --completing the mission, as well as the amount of shuttles that are still
   --alive, in regards to failing the mission.

   --First part is for the Sirius.
   
   if deathcounter == nil then
      deathcounter = 0
   end

   faction_check = pilot.faction(deadpilot)
   if faction_check == faction.get("Sirius") then
      deathcounter = deathcounter + 1
      chanceMsg = rnd.rnd(1,3)
      if killer:exists() and chanceMsg == 1 then
	 selectMsg = rnd.rnd(1,10)
	 killer:broadcast(kilb[selectMsg])
      end
   end
   if deathcounter == #enemy and reinforce_check == "check!" then
      all_enemy_killed = 1
      returning_time()
   end

--This second part is for the shuttles.

   if shuts == nil then
      shuts = {}
   end

   if shuttles_killed == nil then
      shuttles_killed = 0
   end
   for i,p in ipairs(shuts) do
      if p == deadpilot then
         shuttles_killed = shuttles_killed + 1
	 
	 --We need to let the player know somehow.

	 ifm[3] = ifm[3]:format(#shuts-shuttles_killed)
	 msg_check = nil
	 for i,p in ipairs(friend) do
	    if p:exists() and msg_check == nil then
	       p:broadcast(ifm[3],true)
	       msg_check = "check!"
	    end
	 end
	 
	 --update the OSD
	 updateTheOsd()
      end
      
      --end the mission if all the shuttles are killed.

      if shuttles_killed == #shuts then
	 tk.msg(misn_title,shuttles_have_died)
	 abort()
      end
   end

end

function ms_land(landingpilot)

--This function tracks whether or not all of the alive shuttles have landed. 
   if landing_check == nil then
      landing_check = 0
   end
   for i,p in ipairs(shuts) do
      if p == landingpilot then
         landing_check = landing_check + 1
         if landing_check == #shuts - shuttles_killed then
            tk.msg(misn_title,shuttles_have_docked)
            all_shuttles_landed = 1
            returning_time()

	    --need to update the OSD regarding all the shuttles landed.
	    misn.osdDestroy()
	    creatingTheOsd()
	    osd[3] = [[Take out the opposing Sirius fleet. All remaining shuttles have landed.]]
	    misn.osdCreate(misn_title,osd)
	    misn.osdActive(3)
         end
      end
   end
end

function returning_time()

--After the mission objectives have been completed, this function cleans up the system

   if all_enemy_killed == 1 and all_shuttles_landed == 1 then

      --Broadcast the mission objectives as complete.

      ifm[5] = ifm[5]:format(targetasset:name())
      message_check = nil
      for i,p in ipairs(friends) do
	 if p:exists() and message_check == nil then
	    p:broadcast(ifm[5],true)
	    message_check = "check!"
	 end
      end
      
      --Allow the player to land on Obelisk.

      targetasset:landOverride(true)

      --Clean stuff up and send the remaining pilots home.

      mission_status = 2
      misn.osdActive(4)
      for i,p in ipairs(friend) do
	 if p:exists() then
            p:setNoLand(false)
	    p:setNoJump(false)
	    p:control()
	    p:land(targetasset)
         end
      end
   end
end

function land()

   --Handles the end-of-mission.

   if mission_status == 2 and planet.cur() == targetasset then
      emsg[1] = emsg[1]:format(targetasset:name())
      tk.msg(misn_title,emsg[1])
      tk.msg(misn_title,emsg[2])
      player.pay(reward)
      rep_to_add = 7 - shuttles_killed
      tracker = var.peek("heretic_misn_tracker")
      tracker = tracker + 1
      faction.modPlayer("Nasin",rep_to_add)
      var.push("heretic_system_state",2)
      var.push("heretic_misn_tracker",tracker)
      misn.finish(true)
   elseif mission_status == 1 then
      abort()
   end
end

function abort()
   misn.osdDestroy()
   misn.finish(false)
end

