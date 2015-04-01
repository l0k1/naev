--[[If the player runs off with the prototype ship in mission 4 of the Corporate War campaign, 
    there is a chance that the enemy faction will come and offer to trade the ship with their new
    prototype. This will increase faction rep, etc.

   Requirements for the event to run:
   -player is in the prototype ship from the corporate_war campaign.
   -the stolen variable == 1.

    Also using this to clean up campaign variables, as stealing the ship is an alternate ending.
]]--

title = [[An Offer]]
offerMsg = [[You land on %s, and are strolling around the docks when a well-dressed woman approaches you with a briefcase in hand. "Hello, %s. I represent %s, and we have an offer for you. We understand you are in posession of a prototype ship developed by %s. We would like to give you a new %s ship that is being developed, %d credits, and improved relations with %s, in exchange for that ship. Will you accept our offer?" The woman looks at you impatiently as you think about this dramatic turn in events.]]
acceptMsg = [[The woman smiles in a I-just-got-the-better-end-of-the-bargain way, and it doesn't make you feel very comfortable. The credit chip she places into your hand, however, does. "Thank you for your time, %s, and thank you for the chance to do business. Your new ship is waiting at here at Dock 12-G." She turns and strides away, and you wander off to go take a gander at your new ship.]]
declineMsg = [[The woman tsks, and shakes her head. "I hope you realize that was a once in a lifetime offer." She turns and strides briskly away, and you lose her in the crowd.]]

function create()

   friendlyFaction = faction.get(var.peek("corpWarFaction"))
   enemyFaction = faction.get(var.peek("corpWarEnemy"))

   reward = (enemyFaction:playerStanding() + 100) * 4000

   offerMsg = offerMsg:format(planet.cur():name(),player.name(),enemyFaction:name(),friendlyFaction:name(),enemyFaction:name(),reward,enemyFaction:name())
   if not tk.yesno(title,offerMsg) then
      tk.msg(title,declineMsg)
      evt.finish(true)
   end
   acceptMsg = acceptMsg:format(player.name())
   tk.msg(title,acceptMsg)
   
   player.pay(reward)
   if enemyFaction:name() == "Goddard" then
      replacementShip = "Goddard MkII"
   else
      replacementShip = "Kestrel MkII"
   end

   player.swapShip(replacementShip,"Dragon Fire",nil,false,true)
   
   repMod = 15
   enemyFaction:modPlayer(repMod)

   --the campaign is now over, so clean up our variables.
   var.pop("corpWarFaction")
   var.pop("corpWarEnemy")
   var.pop("corpWarStolen")

   evt.finish(true)
end
