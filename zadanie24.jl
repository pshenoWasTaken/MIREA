using HorizonSideRobots
r = Robot(animate = true)

inverse(s) = HorizonSide(mod(Int(s) + 2, 4))


function half_distance!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        kosv!(robot, side)
        move!(robot, inverse(side))
    end
end

function kosv!(robot, side)
    if !isborder(robot, side)
        move!(robot, side)
        half_distance!(robot, side)
    end
end



