using HorizonSideRobots
r = Robot(animate = true)

function kross!(robot)
    for side in ((Nord, Ost), (Nord, West), (Sud, Ost), (Sud, West))
        x = putmarker_along!(robot, side)
        some_steps(robot, inverse(side), x)
    end
end


HorizonSideRobots.move!(robot, side::NTuple{2,HorizonSide}) = for s in side move!(robot, s) end

HorizonSideRobots.isborder(robot, side::NTuple{2, HorizonSide}) = isborder(robot, side[1]) || isborder(robot, side[2])

function inverse(side::NTuple{2, HorizonSide})
    return (HorizonSide(mod(Int(side[1]) + 2, 4)), HorizonSide(mod(Int(side[2]) + 2, 4)))
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

function some_steps(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

