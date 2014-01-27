-- New approach to the formation object.
-- First define the base object. There are no default values, I only wrote in the variables for reader reference.
Forma = {
         fleet = nil,
         formation = nil,
         fleader = nil,
         fleetspeed = nil,
         thook = nil,
         incombat = nil,
}

-- The functions below that start with Forma: are all elements of the Forma table above.
-- Every such function is automatically passed the Forma object they are called on.
-- This object is referenced as "self".

-- Create a new object based on the Forma "class".
-- Usage: forma = Forma:new(table_of_pilots, "formation_name")
function Forma:new(fleet, formation)
   -- Sanity: we want to make sure a fleet was specified. The formation can be nil.
   if not fleet then
      error "Forma must have a fleet."
      return
   end

   -- Create the object.
   local forma = {fleet = fleet, formation = formation}
   setmetatable(forma, self) -- Metatable fanciness.
   self.__index = self -- This means the object will look for its functions in "Forma" if it doesn't have them itself.

   -- Set up stuff and start control loop.
   for _, p in ipairs(forma.fleet) do
      -- We pass the Forma object itself to the hooks.
      d1 = hook.pilot(p, "death", "dead", forma)
      d2 = hook.pilot(p, "jump", "jumper", forma)
      d3 = hook.pilot(p, "land", "lander", forma)
   end
   
   forma:reorganize()
   forma:control() -- This is sadly the only time we can do this.

   return forma, self.fleader --return the fleader so control of the fleet can be handled in a script.
end

-- Cleans up a forma object.
function Forma:destroy()
   if self.thook then
      hook.rm(self.thook)
   end

   -- Sanity: remove any pilots that might still be around.
   for _, p in ipairs(self.fleet) do
      p:rm()
   end

   -- Finally, remove the object itself.
   self = nil
end

function Forma:disband()
   if self.thook then
      hook.rm(self.thook)
   end
   
   self = nil
end

-- Reorganizes a formation.
-- Finds the slowest ship in a fleet and assigns it the leader role.
function Forma:reorganize()
   local minspeed = nil -- Holds the LOWEST speed we know.
   local pspeed = nil -- Holds the speed for the current pilot.
   local fleader = nil -- Holds the pilot with the lowest speed.

   for _, p in ipairs(self.fleet) do -- We will assume there are no gaps in the table, so we don't need to check if any pilots exist. See dead() for why.
      pspeed = p:stats().speed_max-- + p:stats().thrust / 3
      if not minspeed or minspeed > pspeed then -- nil is equivalent to false in Lua.
         minspeed = pspeed
         fleader = p
      end
   end

   if self.formation == "buffer" then
      self:shipCount()
   end
   
   self.fleader = fleader
   self.fleetspeed = minspeed
   self.incombat = false --Combat flag, used in the controlling function.
end

-- Death function. Removes a pilot from a fleet and reorganizes the fleet if necessary.
function Forma:dead(victim)
   for i, p in ipairs(self.fleet) do
      if p == victim then
         table.remove(self.fleet, i) -- This will automatically reorganize the table, so there won't be any entries for pilots that have been removed.
         break -- Don't keep iterating after a table.remove, as it can cause trouble.
      end
   end

   -- Now, if our fleet has been completely wiped out, we need to clean up.
   if #self.fleet == 0 then
      self:destroy()
      return
   end

   -- We need to update the fleet's organization if the leader got killed.
   if victim == self.fleader then
      self:reorganize()
   end
   
   -- Update the ship count if the formation is "buffer".
   if self.formation == "buffer" then
      self:shipCount()
   end
end

function Forma:shipCount()
   self.class_count = {}
   for i, p in ipairs(self.fleet) do
      local classy = p:ship():class()
      if self.class_count[classy] == nil then
         self.class_count[classy] = 1
      else
         self.class_count[classy] = self.class_count[classy] + 1
      end
   end
   for i,p in pairs(self.class_count) do
   end
end
   

-- Jump hook. Ensures the entire fleet jumps if the fleader jumps.
-- Takes an ID that tells this function which formation the pilot belonged to.
function Forma:jumper(jumper)
   if jumper == self.fleader then
      dead(jumper) -- Jumping out is the same as dying, for our purpose.
      for _, p in self.fleet do
         p:control() -- control pilots or clear their orders.
         p:hyperspace() -- TODO: make them use the same jump point as the leader. We can't easily fetch the destination (not if the AI decided to jump on its own),
                        -- but we can check which jump point is closest, which should work most of the time. Don't feel like adding this right now. </lazy>
                        -- Suffice to say though that the same method I used for getting the fleet's maximum speed applies.
      end

      -- Stop the control loop, or it will override our hyperspace() order.
      if self.thook then
         hook.rm(self.thook)
      end
   end
end

-- Land hook. Ensures the entire fleet lands if the fleader lands.
-- Takes an ID that tells this function which formation the pilot belonged to.
function Forma:lander(lander)
   if lander == self.fleader then
      self:dead(lander) -- Landing is the same as dying, for our purpose.
      for _, p in self.fleet do
         p:control() -- control pilots or clear their orders.
         p:land() -- TODO: make them use the same asset as the leader.
      end

      -- Stop the control loop, or it will override our land() order.
      if self.thook then
         hook.rm(self.thook)
      end
   end
end

-- Hooks. The hook functions are just wrappers for the Forma functions.
-- We need these because hooks can't reference table elements as their callbacks.
function dead(victim, killer, forma)
   forma:dead(victim)
end

function jumper(jumper, forma)
   forma:jumper(jumper)
end

function lander(lander, forma)
   forma:lander(lander)
end

--Used in formation creation, this creates vec2s for each ship to follow.
-- Defined on a formation table.
-- This is where formations will ultimately be defined.
function Forma:assignCoords()
   local posit = {} --position array. I'm using this twice, once for polar coordinates and once for absolute vec2s.
   local numships = #self.fleet -- Readability.
   local offset, x, y, angle, radius, count, flip

   if numships <= 1 then
      return {} -- A fleet of 1 ship or less has no business flying in formation.
   end

  if self.formation == "cross" then
      -- Cross logic. Forms an X.
      angle = math.pi / 4 -- Spokes start rotated at a 45 degree angle.
      radius = 100 -- First ship distance.
      for i = 1, numships do
         posit[i] = {angle = angle, radius = radius} -- Store as polar coordinates.
         angle = (angle + math.pi / 2) % (math.pi * 2) -- Rotate spokes by 90 degrees.
         radius = 100 * (math.floor(i / 4) + 1) -- Increase the radius every 4 positions.
      end
      
   elseif self.formation == "buffer" then
      -- Buffer logic. Consecutive arcs eminating from the fleader. Stored as polar coordinates.
      local radii = {Scout = 1000, Fighter = 750, Bomber = 650, Corvette = 500, Destroyer = 400, Cruiser = 300, Carrier = 150} -- Different radii for each class.
      local count = {Scout = 1, Fighter = 1, Bomber = 1, Corvette = 1, Destroyer = 1, Cruiser = 1, Carrier = 1} -- Need to keep track of positions already iterated through.
      for i, p in ipairs(self.fleet) do
         classy = p:ship():class() -- For easy reading.
         if self.class_count[classy] == 1 then -- If there's only one ship in this specific class...
            angle = 0 --The angle needs to be zero.
         else -- If there's more than one ship in each class...
            angle = ((count[classy]-1)*((math.pi/2)/(self.class_count[classy]-1)))-(math.pi/4) -- ..the angle rotates from -45 degrees to 45 degrees, assigning coordinates at even intervals.
            count[classy] = count[classy] + 1 --Update the count
         end
         radius = radii[classy] --Assign the radius, defined above.
         posit[i] = {angle = angle, radius = radius}
      end

   elseif self.formation == "vee" then
      -- The vee formation forms a v, with the fleader at the apex, and the arms extending in front.
      angle = math.pi / 4 -- Arms start at a 45 degree angle.
      radius = 100 -- First ship distance.
      for i = 1, numships do
         posit[i] = {angle = angle, radius = radius} -- Store as polar coordinates.
         angle = angle * -1 -- Flip the arms between -45 and 45 degrees.
         radius = 100 * (math.floor(i / 2) + 1) -- Increase the radius every 4 positions.
      end
   
   elseif self.formation == "wedge" then
      -- The wedge formation forms a v, with the fleader at the apex, and the arms extending out back.
      flip = -1
      angle = (flip * (math.pi / 4)) +  math.pi
      radius = 100 -- First ship distance.
      for i = 1, numships do
         posit[i] = {angle = angle, radius = radius} -- Store as polar coordinates.
         flip = flip * -1
         angle = (flip * (math.pi / 4)) + math.pi-- Flip the arms between 135 and 215 degrees.
         radius = 100 * (math.floor(i / 2) + 1) -- Increase the radius every 4 positions.
      end
      
   --TODO: ECHELON LEFT, ECHELON RIGHT, FISHBONE, CHEVRON, COLUMN, STAGGERED COLUMN, WALL, STAGGERED WALL, SCATTER
      
   else
      -- Default to circle.
      angle = math.pi * 2 / numships -- The angle between each ship, in radians.
      radius = 80 + numships * 25 -- Pulling these numbers out of my ass. The point being that more ships mean a bigger circle.
      for i = 1, numships do
         posit[i] = {angle = angle * i, radius = radius} -- Store as polar coordinates.
      end
   end

   for i, position in ipairs(posit) do
      offset = self.fleader:dir() --We want a fleet formed in positions relative to the direction the captain is facing, not static offsets. Note: dir() is in radians!
      x = position.radius * math.cos(position.angle + offset) --x coordinate assignment.
      y = position.radius * math.sin(position.angle + offset) --y coordinate assignment.
      posit[i] = self.fleader:pos() + vec2.new(x, y) -- You can add and subtract vec2s as you would expect to, no need to bend over backwards.
   end
   return posit
end

-- Formation control function. A wrapper again.
function toRepeat (forma)
   forma:control()
end

function Forma:control()
   local combat_dist = 3000 -- distance at which to begin engaging enemies.
   local inrange = false --Using false instead of nil for readability.

   -- A little unconventional, re-set the timer hook at the start of the function. This is because execution might not reach the end.
   self.thook = hook.timer(100, "toRepeat", self) -- Call the wrapper, not this function.
   
   ---------------
   --combat. mmmm.
   ---------------
   local enemies = pilot.get(self.fleader:faction():enemies()) -- Get all enemies of the fleader. NOTE: This assumes an enemy of the fleader is also an enemy of the fleet! For now that's okay, but keep that in mind.
   if self.fleader:hostile() then
      enemies[#enemies+1] = player.pilot() -- Includes the player as an enemy to be iterated over.
   end

   for _, enemy in ipairs(enemies) do --Iterate over enemies to see if at least one is in range.
      if enemy:pos():dist(self.fleader:pos()) < combat_dist then
         inrange = true --The inrange variable was already defaulted to false.
         break --If an enemy is in range, no need to continue looping.
      end
   end
   
   --We want to seperate out the for loop that finds enemies and the if functions that control combat, so that all of the enemy pilots are iterated over to see if one is in range before controlling the pilots.
   --It's also easier on my brain. </lazy>
   
   if inrange then
      if not self.incombat then --If baddies are in range and the fleet isn't set to do combat yet, then...
         for _, p in ipairs(self.fleet) do
            p:control(false) -- ...cut 'em loose.
         end
         self.incombat = true
         return -- No need to iterate further. No need to do the rest of this function either!
      else
         return --If baddies are in range, and the fleet was already in combat, no need to de-control them again. Prevents spam broadcasting.
      end
   else --If no badguys are in range...
      if self.incombat then --...and the fleet is no longer in combat, then...
         self.incombat = false --...flip the combat flag, and continue the function.
      end
   end
      
   
   -- At this point we know we're not in combat (well, the leader isn't).
   -- Assign the coordinates.
   local posit = self:assignCoords()

   -- Remember, there is no need to check if a pilot exists, because we've already made sure all pilots exist.
   for i, p in ipairs(self.fleet) do
      if not (p == self.fleader) then
         p:setSpeedLimit((self.fleetspeed) + ((p:stats().speed_max - (self.fleetspeed)) * (math.min(50, p:pos():dist(posit[i])) / 50)))
         p:control() -- Clear orders.
         p:goto(posit[i], false, false)
      else
         p:setSpeedLimit(self.fleetspeed) -- Make mon capitan travel at 5 below the slow speed, so other ships can catch up.
         -- Logic for fleet leader goes here. For now, let's allow the fleader to act according to the regular AI:
         -- self.fleader:control(false)
      end
   end
end
