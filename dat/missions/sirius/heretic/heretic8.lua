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

targetasset,targetsys = planet.get("Aldarus")
secasset = planet.get("Solpere")
meetsys = system.get("Tartan")

nasin_rep = faction.playerStanding("Nasin")
reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

function create ()
   --this mission attempts to claim the Palovi system.
   
   
   if not misn.claim(targetsys) and misn.claim(meetsys) then
      misn.finish(false)
   end
   
   --open up the mission.
   misn.setNPC(npc_name,"neutral/thief1")
   misn.setDesc(bar_desc)

end


function accept ()
   
   bmsg[1] = bmsg[1]:format(targetsys:name(),targetsys:name())
   emsg[1] = emsg[1]:format(targetsys:name())   --find the meetsys
   
   misn_desc = misn_desc:format(targetsys:name())

   --get the nasin rep and calculate the reward.
   
   if not tk.yesno(misn_title,bmsg[1]) then
      misn.finish(false)
   end
   misn.accept()
   misn.setTitle(misn_title)
   misn.setReward("Reward: " .. reward)
   misn.setDesc(misn_desc)
   
   meetthemark = misn.markerAdd(meetsys, "plot")
   
   updateOsd()
   
   hook.jumpin("jumper")

end

function jumper ()
   
   --hook following jumps. There are 2 main jump portions.
   
   if system.cur() == meetsys and misn_status == nil then
      
      pilot.clear()
      pilot.toggleSpawn("Sirius", false)
      pilot.toggleSpawn("Pirate", false)
      --handles the in-space meeting.
      mf = {}
      --create the fleet at a semi-random vec2.
      mf[1] = pilot.add("Nasin Med Defense Fleet", nil, vec2.new(0,0))
      mf[2] = pilot.add("Nasin Med Defense Fleet", nil, vec2.new(0,0))
      mf[3] = pilot.add("Nasin Assault Fleet", nil, vec2.new(0,0))
      for _, v in ipairs(mf) do
         for _, p in ipairs(v) do
            p:control(true)
            p:brake(true)
            p:setFriendly(true)
            p:setVisplayer(true)
            if p ~= mf[3][1] then
               p:face(mf[3][1], true)
            end
         end
      end
      meeting_mark = system.mrkAdd("Nasin Fleet", mf[3][1]:pos())
      hook.date(time.create(0,0,100),"proximity",{location=mf[3][1]:pos(),radius=700,funcname="space_meeting"})
      hook.pilot(nil,"jump","time_for_jump")
      
   elseif system.cur() == targetsys and misn_status == 1 then
      
      --handles the combat after the in-space meeting.
      
      pilot.clear()
      pilot.toggleSpawn(false)
      misn_status = 2
      def = {}
      as = {}
      def[1] = pilot.add("Sirius Defense Fleet", nil, vec2.add(targetasset:pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500)))
      def[2] = pilot.add("Sirius Defense Fleet", nil, vec2.add(secasset:pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500))) 
      as[1] = pilot.add("Nasin Med Defense Fleet", nil, meetsys)
      as[2] = pilot.add("Nasin Assault Fleet", nil, meetsys)
      as[3] = pilot.add("Nasin Med Defense Fleet", nil, meetsys)
      for _, v in ipairs(def) do
         for _, p in ipairs(v) do
            p:setNoJump()
            p:setNoLand()
            p:setVisible(true) --otherstuff
            p:setHostile(true)
         end
      end
      for _, v in ipairs(as) do
         for _, p in ipairs(v) do
            p:setNoJump()
            p:setNoLand()
            p:setVisible(true)
            p:setFriendly(true)
         end
      end
      updateOsd()
      hook.pilot(nil, "death", "deadders")
      hook.land("lander")
   elseif system.cur() ~= targetsys and misn_status == 2 then
      tk.msg(misn_title, fail[1])
      misn.finish(false)
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
         mf[3][1]:broadcast(brief[1],false)
         msg_1_check = 1
      elseif time.get() >= current_time + time.create(0,0,151) and time.get() <= current_time + time.create(0,0,250) and msg_2_check == nil then
         mf[3][1]:broadcast(brief[2],false)
         msg_2_check = 1
      elseif time.get() >= current_time + time.create(0,0,251) and time.get() <= current_time + time.create(0,0,350) and msg_3_check == nil then
         mf[3][1]:broadcast(brief[3],false)
         msg_3_check = 1
         system.mrkRm(meeting_mark)
         
         --commands for flight
         
         max_speed = 10000
         for _, v in ipairs(mf) do
            for _, p in ipairs(v) do
               spe_check = pilot.stats(p)
               if spe_check.speed_max < max_speed then
                  max_speed = spe_check.speed_max
               end
            end
         end
         
         for _, v in ipairs(mf) do
            for i, p in ipairs(v) do
               if i == 1 or i == 2 or i == 3 then
                  p:brake(false)
                  p:hyperspace(targetsys)
                  p:setSpeedLimit(max_speed)
               elseif v[math.ceil(i/3)] ~= nil then
                  p:brake(false)
                  p:follow(v[math.ceil(i/3)])
                  p:setSpeedLimit(max_speed)
               else
                  p:brake(false)
                  p:follow(mf[3][1])
                  p:setSpeedLimit(max_speed)
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
   if deadpilot:faction() == faction.get("Sirius") then
      if sirius_killed == nil then
         sirius_killed = 1
      else
         sirius_killed = sirius_killed + 1
      end
      if sirius_killed >= #def[1]+#def[2] and misn_status == 2 then
         misn_status = 3
         tk.msg(misn_title, crisis[1])
         hook.timer(10000, "phase2")
      end
      updateOsd()
   end
   if killer == pilot.player() then
      if player_killed == nil then
         player_killed = 1
      else
         player_killed = player_killed + 1
      end
   end
   if misn_status == 3 and delegate ~= nil then
      for i, p in ipairs(delegate) do
         if delegate_killed == nil then
            delegate_killed = 0
         end
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
   new_enemy = pilot.add("Sirius Med Patrol", nil, system.get("Eiderdown"))
   delegate = pilot.add("Sirius Delegation", nil, system.get("Eiderdown"))
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
   osd[1] = osd[1]:format(meetsys:name())
   osd[2] = osd[2]:format(targetsys:name())
   osd[4] = osd[4]:format(targetasset:name())
   misn.osdDestroy()
   if misn_status == 2 then
      if sirius_killed == nil then
         sirius_killed = 0
      end
      osd[3] = osd_new:format(#def[1]+#def[2]-sirius_killed)
   end
   if misn_status == 3 then
      osd[3] = osd_crisis
   end
   misn.osdCreate(misn_title, osd)
   if misn_status ~= nil and misn_status >= 3 then
      misn.osdActive(misn_status)
   elseif misn_status ~= nil then
      misn.osdActive(misn_status+1)
   end
end

function time_for_jump(p_jumper)

   --After the "lead" ships in the meetsys have jumped, the remainder
   --ships will then be told to jump.

   if p_jumper == mf[2][1] or p_jumper == mf[2][2] or p_jumper == mf[2][3] then
      for k, v in ipairs(mf) do
         for i, p in ipairs(mf[k]) do
            if p ~= p_jumper and p:exists() then
               p:hyperspace(targetsys)
            end
         end
      end
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
