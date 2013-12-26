--[[misn title - the divine]]
--[[blockade]]

lang = naev.lang()

--descriptions and dialogue

function create ()

end


function accept ()

      misn.accept()  -- For missions from the Bar only.
      misn.setTitle( misn_title)
      misn.setReward( misn_reward)
      misn.setDesc( misn_desc)

end


function abort ()
   
end