using HorizonSideRobots
r = Robot(animate = true)

right(side) = HorizonSide(mod(Int(side) + 3, 4))

function find_marker!(robot)
    max_steps = 1
    side = Nord
    while !ismarker(robot)
        find_marker_along!(robot, side, max_steps)
        side = right(side)
        find_marker_along!(robot, side, max_steps)
        side = right(side)
        max_steps += 1
    end
end


function find_marker_along!(robot, side, max_steps)
    num_steps = 0
    while num_steps < max_steps && !ismarker(robot)
        move!(robot, side)
        num_steps += 1
    end
end
