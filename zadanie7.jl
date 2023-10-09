using HorizonSideRobots
r = Robot(animate = true)

inverse(side) = HorizonSide(mod(Int(side) + 2, 4))

function find_pass!(robot)
    num_steps = 1
    side = Ost
    while isborder(robot, Nord)
        along!(robot, side, num_steps)
        num_steps += 1
        side = inverse(side)
    end
end


function along!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

