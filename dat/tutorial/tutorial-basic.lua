-- This is the first tutorial: basic operation.

include("scripts/proximity.lua")
include("dat/tutorial/tutorial-common.lua")

-- localization stuff, translators would work here
lang = naev.lang()
if lang == "es" then
else -- default english
    title1 = "Tutorial: Basic operation"
    message1 = [[Welcome to tutorial: Basic operation.

This tutorial will teach you what Naev is about, and show you the elementary controls of your ship.]]
    message2 = [[We will start by flying around. Use %s and %s to turn, and %s to accelerate. Try flying around the planet.]]
    message3 = [[Flying is easy, but stopping is another thing. To stop, you will need to thrust in the direction you're heading in. To make this task easier, you can use %s to reverse your direction. Once you have turned around completely, thrust to decrease your speed. Try this now.]]
    message4 = [[Well done. Maneuvering and stopping will be important for playing the game.
    
During the game, however, you will often need to travel great distances within a star system. To make this easier, you can use the overlay system map. It is accessed with %s. Open the overlay map now.]]
    message5 = [[This is the system overlay map. It displays an overview of the star system you're currently in, displaying planets, jump points and any ships your scanners are currently detecting.
You can use the overlay map to navigate around the system. Right click on a location to make your ship automatically fly there. Time will speed up during the journey, so you'll be there shortly.

There is a marker on the map. Order your ship to fly to it.]]
    message6 = [[Excellent. Autopilot navigation in time compression is the most convenient way to get around in a system. Not that the autopilot will NOT stop you, you need to do that yourself.

As you can see, there is another ship here. We're going to board it. For this, you must do three things.
- First, target the ship. You can do this with %s, or by clicking on the ship.
- Then, come to a (near) stop right on top of the ship. You learned how to do this earlier.
- Finally, use %s to board the ship.]]
    message7 = [[You have successfully boarded the ship. Boarding is useful in a number of situations, for example when you want to steal cargo or credits from a ship you've disabled in combat, or if a ship is asking for help.
    
The final step in this tutorial is landing. Landing works the same way as boarding, but with planets and stations. Target a planet with %s or the mouse, then use %s to request landing permission. If permission is granted, slow to a stop over the planet or station, then press %s again to land.

Land on Paul 2 now. Remember, you can use the overlay map to get there quicker!]]
    message8 = [[Good job, you have landed on Paul 2. Your game will automatically be saved whenever you land. As a final tip, you can press %s even if you haven't targeted a planet or station - you will automatically target the nearest landable one.

Congratulations! This concludes tutorial: Basic operation.]]
    
    flyomsg = "Fly around (%ds remaining)"
    stopomsg = "Press and hold %s until you stop turning, then thrust until you come to a (near) stop"
    mapomsg = "Press %s to open the overlay map"
    boardomsg = "Target the ship with %s, then approach it and press %s to board"
    landomsg = "Target Paul 2 with %s, then request landing permission with %s. Once granted, prsee %s again to land"
end

function create()
    misn.accept()
    -- Set up the player here.
    player.teleport("Mohawk")

    pilot.clear()
    pilot.toggleSpawn(false) -- To prevent NPCs from getting targeted for now.
    player.pilot():setPos(planet.get("Paul 2"):pos() + vec2.new(0, 250))
    
    enable = {"menu", "accel", "left", "right"}
    enableKeys(enable)
    
    tkMsg(title1, message1, enable)
    tkMsg(title1, message2:format(tutGetKey("left"), tutGetKey("right"), tutGetKey("accel")), enable)
    
    flytime = 10 -- seconds of fly time
    
    omsg = player.omsgAdd(flyomsg:format(flytime), 0)
    hook.timer(1000, "flyUpdate")
end

-- Allow the player to fly around as he likes for 10s.
function flyUpdate()
    flytime = flytime - 1
    
    if flytime == 0 then
        player.omsgRm(omsg)
        tkMsg(title1, message3:format(tutGetKey("reverse")), enable)

        enable = {"menu", "accel", "reverse"}
        enableKeys(enable)
    
        omsg = player.omsgAdd(stopomsg:format(tutGetKey("reverse")), 0)
        braketime = 0 -- ticks for brake check.
        hook.timer(500, "checkBrake")
    else
        player.omsgChange(omsg, flyomsg:format(flytime), 0)
        hook.timer(1000, "flyUpdate")
    end
end

-- Check if the player has managed to stop.
function checkBrake()
    if player.pilot():vel():mod() < 50 then
        braketime = braketime + 1
    else
        braketime = 0
    end
    
    if braketime > 4 then
        -- Have been stationary (or close enough) for long enough
        player.omsgRm(omsg)
        tkMsg(title1, message4:format(tutGetKey("overlay")), enable)
        omsg = player.omsgAdd(mapomsg:format(tutGetKey("overlay")), 0)
        player.pilot():setVel(vec2.new()) -- Stop the player completely
        waitmap = true
        hook.input("input")

        enable = {"menu", "overlay"}
        enableKeys(enable)
    else
        hook.timer(500, "checkBrake")
    end
end

-- Input hook.
function input(inputname, inputpress)
    if waitmap and inputname == "overlay" then
        player.omsgRm(omsg)
        tkMsg(title1, message5, enable)
        targetpos = vec2.new(-3500, 3500) -- May need an alternative?
        marker = system.mrkAdd("Fly here", targetpos)
        waitmap = false

        boardee = pilot.add("Civilian Gawain", nil, targetpos)[1]
        boardee:disable()
        hook.pilot(boardee, "board", "board")

        proximity({location = targetpos, radius = 350, funcname = "proxytrigger"})
    end
end

-- Function that runs when the player approaches the indicated coordinates.
function proxytrigger()
    system.mrkClear()
    tkMsg(title1, message6:format(tutGetKey("target_next"), tutGetKey("board")), enable)
    omsg = player.omsgAdd(boardomsg:format(tutGetKey("target_next"), tutGetKey("board")), 0)

    enable = {"menu", "accel", "left", "right", "target_next", "board"}
    enableKeys(enable)
end

-- Board hook for the board practice ship.
function board()
    player.unboard()
    tkMsg(title1, message7:format(tutGetKey("target_planet"), tutGetKey("land"), tutGetKey("land")), enable)
    player.omsgChange(omsg, landomsg:format(tutGetKey("target_planet"), tutGetKey("land"), tutGetKey("land")), 0)
    hook.land("land")
    -- TODO: Enable target planet, land

    enable = {"menu", "accel", "left", "right", "target_planet", "land"}
    enableKeys(enable)
end

-- Land hook.
function land()
    tkMsg(title1, message8)
    cleanup()
end

-- Abort hook.
function abort()
    cleanup()
end

-- Cleanup function. Should be the exit point for the module in all cases.
function cleanup()
    naev.keyEnableAll()
    -- Function to return to the tutorial menu here
end