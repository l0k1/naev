--[[misn title - the tempest]]
--[[blockade]]

include "proximity.lua"

bmsg = {}
bmsg[1] = [[Homons walks up to you. "SPACE SUPIERIOURITUY, BOOYAH." He high fives you and walks away, chanting, "%s". Apparently, you need to fly to %s. Are you in?]] --targetsys,targetsys

emsg = {}
emsg[1] = [[You land on %s, lost and exhausted. WOO. Time to get back in the air!]]

fail = {}
fail[1] = "you jumped out of the system, fool!"
fail[2] = "the fleet is dead, fool!"
fail[3] = "you landed too early, fool!"

crisis = {}
crisis[1] = [[We just received intel that the delegate ship is inbound. DESTROY.]]

osd = {}
osd[1] = [[Meet up with 9th fleet in %s.]] --meetsys
osd[2] = [[Fly with 9th fleet to %s.]] --targetsys
osd[3] = [[Destroy all Sirius ships.]] --numships
osd[4] = [[Land on %s.]]
osd_new = [[Destroy all Sirius ships. There are %d remaining.]]
osd_crisis = [[Destroy the delegate ship and its escorts.]]

brief = {}
brief[1] = "This is briefing 1!"
brief[2] = "And this is briefing 2!"
brief[3] = "BOOYAH."

npc_name = "Homons"
bar_desc = "A very handsome man."
misn_title = "The Tempest"
misn_desc = "Obtain air superiority in %s, allowing a blockade of all Sirius traffic." --targetsys

function create ()
   --this mission attempts to claim the Palovi system.
   targetasset,targetsys = planet.get("Aldarus")
   secasset = planet.get("Solpere")
   meetsys = system.get("Tartan")
      
   bmsg[1] = bmsg[1]:format(targetsys:name(),targetsys:name())
   emsg[1] = emsg[1]:format(targetsys:name())   --find the meetsys
   tDist = 200 --arbitrary large number.
   tJumps = targetsys:jumps(true)
   for i, j in ipairs(tJumps) do
      sys_check = system.jumpDist(jump.dest(j))
      if tDist > sys_check then
         meetsys = jump.dest(j)
         tDist = syscheck
      end
   end
   misn_desc = misn_desc:format(targetsys:name())
   
   --the first two variables are used in mission failure/success, whereas the third is a crude way to measure the player's effectiveness.
   sirius_killed = 0
   nasin_killed = 0
   player_killed = 0
   delegate_killed = 0
   mf = {}

   --standard misn.claim.
   if not misn.claim(targetsys) then
      misn.finish(false)
   end

   --get the nasin rep and calculate the reward.
   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01


   --open up the mission.
   misn.setNPC(npc_name,"neutral/thief1")
   misn.setDesc(bar_desc)

end


function accept ()
   
   if not tk.yesno(misn_title,bmsg[1]) then
      misn.finish(false)
   end
   misn.accept()
   misn.setTitle(misn_title)
   misn.setReward("Reward: " .. reward)
   misn.setDesc(misn_desc)
   
   osd[1] = osd[1]:format(targetsys:name())
   osd[2] = osd[2]:format(meetsys:name())
   osd[3] = osd[3]:format(targetasset:name())
   
   meetthemark = misn.markerAdd(meetsys, "plot")
   misn.osdCreate(misn_title, osd)
   misn.osdActive(1)

   hook.jumpin("jumper")

end

function jumper ()
   
   --hook following jumps. There are 2 main jump portions.
   
   if system.cur() == meetsys and misn_status == nil then
      
      --handles the in-space meeting.
      
      --create the fleet at a semi-random vec2.
      mf[1] = pilot.add("Nasin Sml Attack Fleet", nil, vec2.new(rnd.rnd(1500,2000),rnd.rnd(-100,100)))
      mf[2] = pilot.add("Nasin Assault Fleet", nil, vec2.new(rnd.rnd(1750,2250),rnd.rnd(0,200)))
      for i1, p1 in ipairs(mf) do
         for i, p in ipairs(mf[i1]) do
            p:control()
            p:setFriendly(true)
            p:brake(true)
         end
      end
      system.mrkAdd("Nasin Fleet", pilot.pos(mf[2][1]))
      hook.date(time.create(0,0,100),"proximity",{location=mf[2][1]:pos(),radius=700,funcname="space_meeting"})
      
   elseif system.cur() == targetsys and misn_status == 1 then
      
      --handles the combat after the in-space meeting.
      
      pilot.clear()
      pilot.toggleSpawn(false)
      misn_status = 2
      updateOsd()
      def = {}
      as = {}
      def[1] = pilot.add("Sirius Defense Fleet", nil, vec2.add(targetasset.pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500)))
      def[2] = pilot.add("Sirius Defense Fleet", nil, vec2.add(secasset.pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500))) 
      as[1] = pilot.add("Nasin Sml Attack Fleet", nil,meetsys)
      as[2] = pilot.add("Nasin Assault Fleet", nil, meetsys)
      for i, p in ipairs(def) do
         for i1, p1 in ipairs(def[i]) do
            p1:setNoJump()
            p1:setNoLand()
            p1:setVisible(true) --otherstuff
            p1:setHostile(true)
         end
      end
      for i, p in ipairs(as) do
         for i1, p1 in ipairs(as[i]) do
            p1:setNoJump()
            p1:setNoLand()
            p1:setVisible(true)
            p1:setFriendly(true)
         end
      end
      updateOsd()
      hook.pilot("deadders",nil,"death")
      hook.land("lander")
   elseif misn_status == 2 then
      tk.msg(misn_title, fail[1])
      misn_finish(false)
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
         mf[2][1]:broadcast(brief[1],false)
         msg_1_check = 1
      elseif time.get() >= current_time + time.create(0,0,151) and time.get() <= current_time + time.create(0,0,250) and msg_2_check == nil then
         mf[2][1]:broadcast(brief[2],false)
         msg_2_check = 1
      elseif time.get() >= current_time + time.create(0,0,251) and time.get() <= current_time + time.create(0,0,350) and msg_3_check == nil then
         mf[2][1]:broadcast(brief[3],false)
         msg_3_check = 1
         system.mrkRm(meeting_mark)
         for i1, p1 in ipairs(mf) do
            for i, p in ipairs(mf[i1]) do
               if i == 1 or i == 2 or i == 3 then
                  p:hyperspace(targetsys)
               elseif good_fleet[math.ceil(i/3)] ~= nil then
                     p:follow(mf[i1][math.ceil(i/3)])
               else
                  p:follow(mf[i1][1])
               end
            end
         end
         misn_status = 1
         updateOsd()
         misn.markerMove(meetthemark,targetsys)
         sm_runthrough = 1
      end
   end
end

function deadders (deadpilot, killer)
   if deadpilot:faction("Sirius") then
      sirius_killed = sirius_killed + 1
      if sirius_killed >= #def[1]+#def[2] and misn_status == 2 then
         misn_status = 3
         tk.msg(misn_title, crisis[1])
         hook.timer(10000, "phase2")
      end
      updateOsd()
   end
   if killer == pilot.player() then
      player_killed = player_killed + 1
   end
   if misn_status == 3 then
      for i, p in ipairs(delegate) do
         if p == deadpilot and killer == pilot.player() then
            player_killed = player_killed + 4
            delegate_killed = delegate_killed + 1
         elseif p == deadpilot then
            delegate_killed = delegate_killed + 1
         end
      end
      if delegate_killed == #delegate then --mission complete
         misn_status = 4
         updateOsd()
      end
   end
end

function phase2 ()
   for i, j in ipairs(tJumps) do
      if j ~= meetsys and jumpsys == nil then
         jumpsys = j
      end
   end
   new_enemy = pilot.add("Sirius Med Patrol", nil, jumpsys)
   delegate = pilot.add("Sirius Delegation", nil, jumpsys)
   for i, p in ipairs(new_enemy) do
      p:setHostile(true)
   end
   for i, p in ipairs(delegate) do
      p:control()
      p:setHilight(true)
      p:setVisible(true)
      p:hyperspace(meetsys,true)
   end
end

function updateOsd ()
   misn.osdDestroy()
   if misn_status == 2 then
      osd[3] = osd_new:format(#def[1]+#def[2]-sirius_killed)
   end
   if misn_status == 3 then
      osd[3] = osd_crisis
   end
   misn.osdCreate(misn_title, osd)
   if misn_status >= 3 then
      misn.osdActive(misn_status)
   else
      misn.osdActive(misn_status+1)
   end
end

function lander ()
   if misn_status == 2 then
      tk.msg(misn_title, fail[3])
      misn_finish(false)
   elseif misn_status == 3 and planet.cur(targetasset) then
      tk.msg(misn_title, emsg[1])
      player.pay(reward)
      rep_to_add = 1 + (math.floor(player_killed / 4))
      if rep_to_add < 0 then
         rep_to_add = 1
      end
      tracker = var.peek("heretic_misn_tracker")
      tracker = tracker + 1
      faction.modPlayer("Nasin",rep_to_add)
      var.push("heretic_misn_tracker",tracker)
      misn.markerRm(meetthemark)
      misn.finish(true)
      --end mission stuff
   end
end

function abort ()
end
