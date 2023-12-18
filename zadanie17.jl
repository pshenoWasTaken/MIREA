using HorizonSideRobots
r = Robot(animate = true)

function spiral!(stop_condition, robot)
    max_num_steps = 1
    side = Nord
    while !stop_condition(robot)
        num_steps = 0
        while num_steps < max_num_steps && !stop_condition(robot)
            move!(robot, side)
            num_steps += 1
        end
        side = left(side)
        num_steps = 0
        while num_steps < max_num_steps && !stop_condition(robot)
            move!(robot, side)
            num_steps += 1
        end
        max_num_steps += 1
        side = left(side)
    end
end

left(side) = HorizonSide(mod(Int(side) + 3, 4))

spiral!(ismarker, r)