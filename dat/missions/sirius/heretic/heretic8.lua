--[[misn title - the tempest]]
--[[blockade]]

bmsg = {}
bmsg[1] = [[Homons walks up to you. "SPACE SUPIERIOURITUY, BOOYAH." He high fives you and walks away, chanting, "%s". Apparently, you need to fly to %s. Are you in?]] --targetsys,targetsys

emsg = {}
emsg[1] = [[You land on %s, lost and exhausted. WOO. Time to get back in the air!]]

osd = {}
osd[1] = [[Fly to %s to assist 9th fleet.]] --targetsys
osd[2] = [[Destroy all Sirius ships. There are %d remaining.]] --numships
osd[3] = [[Land on %s.]]

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

   if not misn.claim(targetsys) then
      misn.finish(false)
   end

   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

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
   
   misn.osdCreate(osd)
   misn.osdActive(1)

end

function jumper ()

   if system.cur() == targetsys then
      pilot.clear()
      pilot.toggleSpawn(false)
      pilot.add (fleetname, nil, vec2) --Sirius Defense Fleet x2, Nasin Sml Attack Fleet, Nasin Assault Fleet
      --pilot.setNoJump()
      --pilot.setNoLand()

end

function abort ()
   
end