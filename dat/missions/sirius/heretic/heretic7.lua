--[[misn title - the thief]]
--[[patrol]]

bmsg = {}
bmsg[1] = [[Marton Heson sits at a table, drinking quietly. He looks up as you arrive. "Good to see you, %s. Good job on that last mission - it's time to step up our game. Are you ready to win one more for the Nasin?"]]
bmsg[2] = [[He clears his throat. "We've been given a new mission. This one is definitely going to knock your socks off." Heson gets up from the table and leaves the bar, motioning for you to follow him. He leads you down several hallways, before emerging into a small hall, filled with pilots you've seen before. You and Heson sit in the back row, next to a couple of men who smell horribly of booze and cheap smokes.]]--playername
bmsg[2] = [[You recognize the face of Homons as he rises in front of the small gathering. The room falls quiet at his presence. "9th Fleet!" He shouts, raising a glass full of water. He is greeted by several hoots and a couple hollers. "We've been given a new mission, straight from Ops. It's going to be..." he took a swig of water, and with a grin on his face he said, "delicious." More cheers followed.]]
bmsg[3] = [[Attes, sitting in the front row, clears his throat loudly, silencing the room once again. Homons continues, bringing up an image of a system on a holo display. "We've received word that several high ranking religious members are going to try and break through Nasin-controlled space and petition the Empire for help. While we don't think it's likely that they will receive help, our higher ups have deemed it necessary to eliminate the problem before it becomes a problem. The Empire, weak as they are, still would be to much for us to handle at this time."]]
bsmg[4] = [["There will be three phases to this mission. We believe they are jumping into this system, %s, through this gate. This is Sirius controlled space, and we have very little knowledge of what is going on. %s has been tasked with scouting it out. We need to know enemy strength, gate stability, asset information, everything. You're ships are being prepped with all necessary equipment and being programmed accordingly. You just need to focus on staying alive.]]--targetsys,playername
bsmg[5] = [["After this information is collected and analyzed back here, we will be jumping in-sector to obtain space supieriority. We will then establish meet up on %s, regroup, and set up a blockade to catch the incoming delegation." He eyes you. "%s - move out. Meet back here afterwards." The many faces in the room turned to watch you as you rise and leave, back to prep for your new mission.]] --targetasset,playername

bar_desc = [[]]
npc_name = [[]]
misn_desc = [[]]
misn_title = "The Thief"


function create ()
   targetasset,targetsys = planet.get("saodsfa")
   if not misn.claim(targetsys) then
      misn.finish(false)
   end

   misn.setNPC(npc_name,"neutral/thief1")
   misn.setDesc(bar_desc)

end


function accept ()
   nasin_rep = faction.playerStanding("Nasin")
   reward = math.floor((10000+(math.random(5,8)*200)*(nasin_rep^1.315))*.01+.5)/.01

   misn.accept()  -- For missions from the Bar only.
   misn.setTitle( misn_title)
   misn.setReward( misn_reward)
   misn.setDesc( misn_desc)

end

function abort ()
   
end