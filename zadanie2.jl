using HorizonSideRobots
r = Robot(animate = true)


function perimetr!(robot)
    cs, cw = comf_position!(robot)
    for side in (Ost, Nord, West, Sud)
        mark_along!(robot, side)
    end
    some_steps!(robot, Nord, cs)
    some_steps!(robot, Ost, cw)
end

function comf_position!(robot)
    cs = 0
    cw = 0
    while !isborder(robot, Sud)
        move!(robot, Sud)
        cs += 1
    end
    while !isborder(robot, West)
        move!(robot, West)
        cw += 1
    end
return cs, cw
end

function mark_along!(robot, side)
    while !isborder(robot, side)
        putmarker!(robot)
        move!(robot, side)
    end
    putmarker!(robot)
end


function some_steps!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end

