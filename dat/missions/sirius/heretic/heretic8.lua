--[[misn title - the tempest]]
--[[blockade]]

bmsg = {}
bmsg[1] = [[Homons walks up to you. "SPACE SUPIERIOURITUY, BOOYAH." He high fives you and walks away, chanting, "%s". Apparently, you need to fly to %s. Are you in?]] --targetsys,targetsys

emsg = {}
emsg[1] = [[You land on %s, lost and exhausted. WOO. Time to get back in the air!]]

fail = {}
fail[1] = "you jumped out of the system, fool!"
fail[2] = "the fleet is dead, fool!"
fail[3] = "you landed too early, fool!"

osd = {}
osd[1] = [[Fly to %s to assist 9th fleet.]] --targetsys
osd[2] = [[Destroy all Sirius ships.]] --numships
osd[3] = [[Land on %s.]]
osd_new = [[Destroy all Sirius ships. There are %d remaining.]]

npc_name = "Homons"
bar_desc = "A very handsome man."
misn_title = "The Tempest"
misn_desc = "Obtain air superiority in %s, allowing a blockade of all Sirius traffic." --targetsys

function create ()
   --this mission attempts to claim the Palovi system.
   targetasset,targetsys = planet.get("Aldarus")
   secasset = planet.get("Solpere")
   bmsg[1] = bmsg[1]:format(targetsys:name(),targetsys:name())
   emsg[1] = emsg[1]:format(targetsys:name())
   misn_desc = misn_desc:format(targetsys:name())
   
   --the first two variables are used in mission failure/success, whereas the third is a crude way to measure the player's effectiveness.
   sirius_killed = 0
   nasin_killed = 0
   player_killed = 0

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
   misn.accept()  -- For missions from the Bar only.
   misn.setTitle(misn_title)
   misn.setReward("Reward: " .. reward)
   misn.setDesc(misn_desc)
   hook.jumpin("jumper")
   
   osd[1] = osd[1]:format(targetsys:name())
   osd[3] = osd[3]:format(targetasset:name())
   
   meetthemark = misn.markerAdd(targetsys, "plot")
   misn.osdCreate(misn_title, osd)
   misn.osdActive(1)

end

function jumper ()
   if system.cur() == targetsys and misn_status == nil then
      pilot.clear()
      pilot.toggleSpawn(false)
      misn_status = 1
      def = {}
      as = {}
      def[1] = pilot.add("Sirius Defense Fleet", nil, vec2.add(targetasset.pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500)))
      def[2] = pilot.add("Sirius Defense Fleet", nil, vec2.add(secasset.pos(),rnd.rnd(-3500,3500),rnd.rnd(-3500,3500))) 
      as[1] = pilot.add("Nasin Sml Attack Fleet", nil,lastsysvisited)
      as[2] = pilot.add("Nasin Assault Fleet", nil, lastsysvisited)
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
   elseif misn_status == 1 then
      tk.msg(misn_title, fail[1])
      misn_finish(false)
   else
      system.cur() = lastsysvisited
end

function deadders (deadpilot, killer)
   if deadpilot:faction("Sirius") then
      sirius_killed = sirius_killed + 1
      if sirius_killed == #def[1]+#def[2] then
         misn_status = 2 --misn complete.
      end
      updateOsd()
   end
   if deadpilot:faction("Nasin") then
      nasin_killed = nasin_killed + 1
      if nasin_killed == #as[1] + #as[2] then
         tk.msg(misn_title,fail[2])
         misn.finish(false)
      end
   end
   if killer == pilot.player() then
      player_killed = player_killed + 1
   end
end

function updateOsd ()
   misn.osdDestroy()
   osd[2] = osd_new:format(#def[1]+#def[2]-sirius_killed)
   misn.osdCreate(misn_title, osd)
   misn.osdActive(misn_status+1)
end

function lander ()
   if misn_status == 1 then
      tk.msg(misn_title, fail[3])
      misn_finish(false)
   elseif misn_status == 2 and planet.cur(targetasset) then
      tk.msg(misn_title, emsg[1])
      player.pay(reward)
      rep_to_add = 1 + (math.floor(player_killed / 4)
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

function abort ()
end
