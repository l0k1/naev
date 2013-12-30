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

   key = var.peek("heretic_system_state")

   --Nasin_systems list systems that will be controlled by the Nasin at some point.
   --I've broken in out into nasin_systems[x] for more clarity.

   nasin_systems = {}
   nasin_systems[1] = {
      system.get("Chraan"),
      system.get("Nougat"),
      system.get("Esker"),
      system.get("Eye of Night"),
      system.get("Gutter"),
      system.get("Pike")
   }

   nasin_systems[2] = {
      system.get("Chraan"),
      system.get("Nougat"),
      system.get("Esker"),
      system.get("Eye of Night"),
      system.get("Gutter"),
      system.get("Pike"), --here and lower are new to [2].
      system.get("Kraft"),
      system.get("Neon"),
      system.get("Nixon"),
      system.get("Kiwi"),
      system.get("Pellmell"),
      system.get("Tartan"),
      system.get("Kyo"),
      system.get("Scarlet"),
      system.get("Valur Gem"),
      system.get("Druss"),
      system.get("Rhu"),
      system.get("Quai"),
      system.get("Ruttwi"),
      system.get("Lapis"),
      system.get("Niger"),
      system.get("Lazuli"),
      system.get("Anarbalis")
   }

   nasin_systems[3] = {
      system.get("Chraan"),
      system.get("Nougat"),
      system.get("Esker"),
      system.get("Eye of Night"),
      system.get("Gutter"),
      system.get("Pike"), --[2]
      system.get("Kraft"),
      system.get("Neon"),
      system.get("Nixon"),
      system.get("Kiwi"),
      system.get("Pellmell"),
      system.get("Tartan"),
      system.get("Kyo"),
      system.get("Scarlet"),
      system.get("Valur Gem"),
      system.get("Druss"),
      system.get("Rhu"),
      system.get("Quai"),
      system.get("Ruttwi"),
      system.get("Lapis"),
      system.get("Niger"),
      system.get("Lazuli"),
      system.get("Anarbalis"), --here and lower are new to [3]
      system.get("Fulcrum"),
      system.get("Duros"),
      system.get("Palovi"),
      system.get("Modus Manis"),
      system.get("Humdrum"),
      system.get("An'ku")
   }

   nasin_systems[4] = {
      system.get("Chraan"),
      system.get("Nougat"),
      system.get("Esker"),
      system.get("Eye of Night"),
      system.get("Gutter"),
      system.get("Pike"), --[2]
      system.get("Kraft"),
      system.get("Neon"),
      system.get("Nixon"),
      system.get("Kiwi"),
      system.get("Pellmell"),
      system.get("Tartan"),
      system.get("Kyo"),
      system.get("Scarlet"),
      system.get("Valur Gem"),
      system.get("Druss"),
      system.get("Rhu"),
      system.get("Quai"),
      system.get("Ruttwi"),
      system.get("Lapis"),
      system.get("Niger"),
      system.get("Lazuli"),
      system.get("Anarbalis"), --[3]
      system.get("Fulcrum"),
      system.get("Duros"),
      system.get("Palovi"),
      system.get("Modus Manis"),
      system.get("Humdrum"),
      system.get("An'ku"), --here and lower are new to [4]
      system.get("Monogram"),
      system.get("Suna"),
      system.get("Anrique"),
      system.get("Herakin"),
      system.get("Eiderdown"),
      system.get("Willow"),
      system.get("Gilligan's Memory"),
      system.get("Tarmak")
   }


   systemControl()

end

function systemControl()
   for i,sys in ipairs(nasin_systems[key]) do
      if system.cur() == sys then
	 pilot.clear()
	 pilot.toggleSpawn("Sirius",false)
	 fleet_battle_roller = rnd.rnd(1,10)
	 planets_in_sys = nil --cleaning up from prior systems.
	 planets_in_sys = system.planets(system.cur())
	 if planets_in_sys[1] ~= nil then
	    for i,plan in ipairs(planets_in_sys) do
	       plan:landOverride(true)
	    end
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

--Handles the regular systems where there isn't large fleet battles.

	 else
	    chance_civvies = rnd.rnd(1,3)
	    chance_mil_small = rnd.rnd(1,7)
	    chance_mil_large = rnd.rnd(1,3)
	    for i = 1,chance_civvies do
	       pilot.add("Nasin Sml Civilian",nil,vec2.new(rnd.rnd(-10000,10000),rnd.rnd(-10000,10000)))
	    end
	    for i = 1,chance_mil_small do
	       pilot.add("Nasin Med Defense Fleet",nil,vec2.new(rnd.rnd(-10000,10000),rnd.rnd(-10000,10000)))
	    end
	    if chance_mil_large == 1 then
	       pilot.add("Nasin Assault Fleet",nil,vec2.new(rnd.rnd(-10000,10000),rnd.rnd(-10000,10000)))
	    end
	 end
      end
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
      if dead_nasin % 5 == 0 then
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
      end
   end
end

function eventFinish()

   --Cleans up event proper-like.

   evt.finish()

end
