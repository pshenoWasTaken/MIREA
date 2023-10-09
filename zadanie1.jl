using HorizonSideRobots
r = Robot(animate = true)

function mark_kross!(robot)
    for side in (Nord, West, Sud, Ost)
        z = putmarker_along!(robot, side)
        along!(robot, inverse(side), z)
    end 
end

function along!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)  
    end
end


function inverse(direct)::HorizonSide
    return HorizonSide(mod(Int(direct) + 2, 4))
end


function putmarker_along!(robot, side)
    c = 0
    while !isborder(robot, side)
        putmarker!(robot)
        move!(robot, side)
        c += 1
    end
    putmarker!(robot)
    return c
end


