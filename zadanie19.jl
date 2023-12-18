using HorizonSideRobots
r = Robot(animate = true)

function recursion_move!(r, side)
    if !isborder(r,side)
        move!(r, side)
        recursion_move!(r,side)
    else 
        return Nothing
    end
end

