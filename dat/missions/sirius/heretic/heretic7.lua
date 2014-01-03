--[[misn title - the thief]]
--[[patrol]]

bmsg = {}
bmsg[1] = [[Marton Heson sits at a table, drinking quietly. He looks up as you arrive. "Good to see you, %s. Good job on that last mission - it's time to step up our game. Are you ready to win one more for the Nasin?"]] --playername
bmsg[2] = [[He clears his throat. "We've been given a new mission. This one is definitely going to knock your socks off." Heson gets up from the table and leaves the bar, motioning for you to follow him. He leads you down several hallways, before emerging into a small hall, filled with pilots you've seen before. You and Heson sit in the back row, next to a couple of men who smell horribly of booze and cheap smokes.]]--playername
bmsg[2] = [[You recognize the face of Homons as he rises in front of the small gathering. The room falls quiet at his presence. "9th Fleet!" He shouts, raising a glass full of a clear liquid. He is greeted by several hoots and a couple hollers. "We've been given a new mission, straight from Ops. It's going to be..." he took a swig of the liquid, and with a grin on his face, and said, "delicious." More cheers followed.]]
bmsg[3] = [[Attes, sitting in the front row, clears his throat loudly, silencing the room once again. Homons continues, bringing up an image of a system on a holo display. "We've received word that several high ranking religious members are going to try and break through Nasin-controlled space and petition the Empire for help. While we don't think it's likely that they will receive help, our higher ups have deemed it necessary to eliminate the problem before it becomes a problem. The Empire, weak as they are, still would be to much for us to handle at this time."]]
bmsg[4] = [["There will be three phases to this mission. We believe they are jumping into this system, %s, through this gate. This is Sirius controlled space, and we have very little knowledge of what is going on. %s has been tasked with scouting it out. We need to know enemy strength, gate stability, asset information, everything. Your ship is being prepped with all necessary equipment and being programmed accordingly. You just need to focus on flying around and staying alive."]]--targetsys,playername
bmsg[5] = [["After this information is collected and analyzed back here, we will be jumping in-sector to obtain space supieriority. We will then meet up on %s, regroup, and set up a blockade to catch the incoming delegation. We will be taking %s, with no reinforcements." He eyes you. "%s - move out. Meet back here afterwards." The many faces in the room turned to watch you as you rise and leave, back to prep for your new mission.]] --targetasset,targetsys,playername
bmsg[6] = [[Marton looks more than a little confused, but nods anyways. "Well, I need to go take a pee. Meet me back here when you're ready." And with that, he walks off, leaving you to yourself.]]

emsg = {}
emsg[1] = "Ending stuff."

bar_desc = [[Marton sits, smiling and drinking something that fizzes.]]
npc_name = [[Marton Heson]]
misn_desc = [[Patrol the %s sector.]] --targetasset
misn_title = "The Thief"

osd = {}
osd[1] = [[Fly to %s.]] --targetsys
osd[2] = [[Scan all targets in the %s system.]] --targetsys
osd[3] = [[Return to %s in %s.]] --curasset,cursys
omsgmes = {}
omsgmes[1] = [[Scan target for %d more seconds.]]
omsgmes[2] = [[You've left too early! Please return.]]
omsgmes[3] = [[Scan complete.]]

function create ()
   --This mission attempts to claim the Palovi system.
   targetasset,targetsys = planet.get("Aldarus")
   secasset = planet.get("Solpere")
   curasset,cursys = planet.cur()

   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

   if not misn.claim(targetsys) then
      misn.finish(false)
   end

   misn.setNPC(npc_name,"neutral/thief1")
   misn.setDesc(bar_desc)

end


function accept ()

   --format opening dialogue
   bmsg[1] = bmsg[1]:format(player.name())
   bmsg[2] = bmsg[2]:format(player.name())
   bmsg[4] = bmsg[4]:format(targetsys:name(),player.name())
   bmsg[5] = bmsg[5]:format(targetasset:name(),targetsys:name(),player.name())
   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

   --dialoge
   thechoice = tk.yesno(misn_title,bmsg[1])
   if thechoice == false then
      tk.msg(misn_title,bmsg[6])
      misn.finish(false)
   end
   tk.msg(misn_title,bmsg[2])
   tk.msg(misn_title,bmsg[3])
   tk.msg(misn_title,bmsg[4])
   tk.msg(misn_title,bmsg[5])

   misn.accept()  -- For missions from the Bar only.
   misn.setTitle(misn_title)
   misn.setReward("Reward: " .. reward)
   misn.setDesc(misn_desc)
   misn_stage = 0

   --need to do OSD.

   initingTheOsd()
   misn.osdCreate(misn_title,osd)
   misn.osdActive(1)

   meetthemark = misn.markerAdd(targetsys,"plot")

   hook.jumpin("jumper")

end

function jumper ()
   pilot.player():setInvincible() --debug
   if system.cur() == targetsys then
      if firstjumpin == nil then
         targs = {}
         targst = {}
         targsid = {}
         targs[1] = planet.pos(targetasset)
         targs[2] = planet.pos(secasset)
         targs[3] = jump.pos(jump.get("Palovi","Eiderdown"))
         targs[4] = jump.pos(jump.get("Palovi","Duros"))
         targs[5] = jump.pos(jump.get("Palovi","Tartan"))
         needcleared = #targs
         totscleared = 0
      end
      misn.osdActive(2)
      firstjumpin = true
      for i = 1, #targs, 1 do
	      targsid[i] = system.mrkAdd("Scan here", targs[i])
	      targst[i] = 0
      end
      patrolTime()
      --if all completed, set "lokisgrace" to true
   elseif system.cur() == cursys and lokisgrace == true then
      hook.land("landed")--ending stuff.
   end
   
end

function patrolTime ()
   timeattarget = 5
   for i, v in ipairs(targs) do
      if vec2.dist(player.pos(),v) < 1000 and targst[i] < timeattarget then
      targst[i] = targst[i] + 1
      ttrm = timeattarget - targst[i]
      newomsgmes = omsgmes[1]:format(ttrm)
         if omsgid == nil then
            omsgid = player.omsgAdd(newomsgmes,5)
         else
            player.omsgChange(omsgid,newomsgmes,5)
         end
      elseif vec2.dist(player.pos(),v) > 1000 and targst[i] > 1 and targst[i] < timeattarget then
         player.omsgChange(omsgid,omsgmes[2],5)
         targst[i] = 0
         omsgid = nil
      elseif vec2.dist(player.pos(),v) < 1000 and targst[i] == timeattarget then
         totscleared = totscleared + 1
         player.omsgChange(omsgid,omsgmes[3],5)
         omsgid = nil
         system.mrkRm(targsid[i])
         table.remove(targs, i)
         table.remove(targsid, i)
      else
         targst[i] = 0
      end
   end --this will time how long a player is within "1000" of the targ.
   if totscleared >= needcleared then
      lokisgrace = true
      misn.markerMove(meetthemark, cursys)
      misn.osdActive(3)
   end
   hook.timer(1000,"patrolTime")
end

function landed () --End of mission stuff.
   if planet.cur() == curasset then
      tk.msg(misn_title, emsg[1])
      player.pay(reward)
      rep_to_add = 5
      tracker = var.peek("heretic_misn_tracker")
      tracker = tracker + 1
      faction.modPlayer("Nasin",rep_to_add)
      var.push("heretic_system_state",3)
      var.push("heretic_misn_tracker",tracker)
      misn.markerRm(meetthemark)
      misn.finish(true)
   end
end

function initingTheOsd ()
   osd[1] = osd[1]:format(targetsys:name())
   osd[2] = osd[2]:format(targetsys:name())
   osd[3] = osd[3]:format(curasset:name(),cursys:name())
end

function abort ()
   
end
