--[[HERETIC HELPER!]]

--[[This is a helper event for the heresy war campaign. This is being used to control Sirius spawning inside what should be Nasin controlled space. I've also used this to introduce random fleet battles, to give the impression that yes, the Sirius are fighting back. I went with this over unidiffs, as this just seems more dynamic.]]

--TODO:
--Mark Nasin controlled systems via system.addMarker.
--Let the playa know what these are via heretic5 ending dialogue.
--Switch to unidiffs.

enemy_fleet_dead = {
"They had that coming! Way to take them out boys! Next round is on me!",
"HQ, this is Fleet Commander Shoto, and we have wiped out the Sirius threat!",
"Alright guys, we can rack up kills later. Lets get back to base and re-arm!",
"Thanks for the assistance fellas! Can't wait to do it again!",
"We showed them! They'll think twice before taking on the Meteor Hammers again!"
}

function create()


   dead_nasin = 0
   dead_sirius = 0

   if not evt.claim(system.cur()) then
      evt.finish()
   end

   --Handles the random, large fleet battles.

   if fleet_battle_roller == 1 then
      vectxe,vectye = rnd.rnd(-7500,7500),rnd.rnd(-7500,7500)
      vectxf,vectyf = rnd.rnd(-7500,7500),rnd.rnd(-7500,7500)
      enemy = pilot.add("Sirius Defense Fleet",nil,vec2.new(vectxe,vectye))
      enemy_bk = pilot.add("Sirius Assault Force",nil,vec2.new(vectxe - 1000,vectye - 1000))
      friend = pilot.add("Nasin Assault Fleet",nil,vec2.new(vectxf,vectyf))
      friend_bk = pilot.add("Nasin Med Defense Fleet",nil,vec2.new(vectxf - 500,vectyf + 500))
      for i,p in ipairs(enemy_bk) do
         table.insert(enemy,p)
      end
      for i,p in ipairs(friend_bk) do
         table.insert(friend,p)
      end
      for i,p in ipairs(enemy) do
         p:setVisible()
         p:setNoJump()
         p:setNoLand()
         p:setHostile()
      end
      for i,p in ipairs(friend) do
         p:setVisible()
         p:setNoJump()
         p:setNoLand()
         p:setFriendly()
      end
      hook.pilot(nil,"death","death")
      hook.timer(300000, "reinforcements")
   end
   hook.jumpout("eventFinish")
end

function death(deadpilot)
   --Moniters dead pilots for the end of the battle. And a little bit of flavaflav.

   if deadpilot:faction() == faction.get("Sirius") then
      dead_sirius = dead_sirius + 1
      if dead_sirius == #enemy then
         for i,p in ipairs(friend) do
            if p:exists() then
               p:setNoJump(false)
               p:setNoLand(false)
               if msg_check == nil then
                  p:broadcast(enemy_fleet_dead[rnd.rnd(1,5)])
                  msg_check = "check!"
               end
            end
         end
      end
   end
   if deadpilot:faction() == faction.get("Nasin") then
      dead_nasin = dead_nasin + 1
   end
end

function reinforcements()
   for i = 1,3 do
   reinforce = pilot.add("Nasin Med Defense Fleet")
      for i,p in ipairs(reinforce) do
      table.insert(friend,p)
      p:setVisible()
      p:setFriendly()
      p:setNoLand(true)
      p:setNoJump(true)
      end
   end
   hook.timer(rnd.rnd(15000,200000),"reinforcements")
end

function eventFinish()

--Cleans up event proper-like.

evt.finish()

end
