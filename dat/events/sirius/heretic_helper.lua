--[[HERETIC HELPER!]]

--[[This is a helper event for the heresy war campaign. This is being used to control Sirius spawning inside what should be Nasin controlled space. I've also used this to introduce random fleet battles, to give the impression that yes, the Sirius are fighting back. I went with this over unidiffs, as this just seems more dynamic.]]

--TODO:
--Mark Nasin controlled systems via system.addMarker.
--Let the playa know what these are via heretic5 ending dialogue.
--Switch to unidiffs.

include("fleet_form.lua")

enemy_fleet_dead = {
"They had that coming! Way to take them out boys! Next round is on me!",
"HQ, this is Fleet Commander Shoto, and we have wiped out the Sirius threat!",
"Alright guys, we can rack up kills later. Lets get back to base and re-arm!",
"Thanks for the assistance fellas! Can't wait to do it again!",
"We showed them! They'll think twice before taking on the Meteor Hammers again!"
}

function create()

   if not evt.claim(system.cur()) then
      evt.finish()
   end
   
   local fleet_form_table = {"cross", "buffer", "vee", "wedge", "circle"}
   
   --Handles the random, large fleet battles.

   local fleet_battle_roller = rnd.rnd(1,7)

   if fleet_battle_roller == 1 then
      pilot.toggleSpawn("Nasin", false)
      pilot.toggleSpawn("Sirius", false)
      pilot.toggleSpawn("Pirate", false)
      pilot.clear()
      vectxe,vectye = rnd.rnd(-7500,7500),rnd.rnd(-7500,7500)
      vectxf,vectyf = rnd.rnd(-7500,7500),rnd.rnd(-7500,7500)
      local enemy = pilot.add("Sirius Defense Fleet",nil,vec2.new(vectxe,vectye)) --debug
      local enemy_bk = pilot.add("Sirius Assault Force",nil,vec2.new(vectxe,vectye))
      local friend = pilot.add("Nasin Assault Fleet",nil,vec2.new(vectxf,vectyf))
      local friend_bk = pilot.add("Nasin Med Defense Fleet",nil,vec2.new(vectxf,vectyf))
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
      Forma:new(friend,fleet_form_table[rnd.rnd(1,#fleet_form_table)])
      Forma:new(enemy,fleet_form_table[rnd.rnd(1,#fleet_form_table)])
      hook.pilot(nil,"death","death",#enemy)
      hook.timer(rnd.rnd(45000,300000), "reinforcements")
   end
   hook.jumpout("eventFinish")
   hook.land("eventFinish")
end

function death(deadpilot, _, num_enemy)
   --Moniters dead pilots for the end of the battle. And a little bit of flavaflav.
   if dead_sirius == nil then
      dead_sirius = 0
   end
   if deadpilot:faction() == faction.get("Sirius") then
      dead_sirius = dead_sirius + 1
      if dead_sirius == num_enemy then
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
end

function reinforcements()
   local reinforce = pilot.add("Nasin Med Defense Fleet")
   for i,p in ipairs(reinforce) do
      p:setVisible()
      p:setFriendly()
      p:setNoLand(true)
      p:setNoJump(true)
   end
   Forma:new(reinforce)
   hook.timer(rnd.rnd(45000,300000),"reinforcements")
end

function eventFinish()

--Cleans up event proper-like.

   evt.finish()

end
