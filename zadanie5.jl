using HorizonSideRobots 
r = Robot(animate = true)

function mark_perimetrs!(robot)
    home = comf_position!(robot)
    external_perimetr!(robot)
    find_internal_border!(robot)
    cool_internal_pos!(robot)
    mark_internal_rect!(robot)
    comf_position!(robot)
    move_back!(robot, home)
end

function comf_position!(robot)
    return (side = Nord, num_steps = numsteps_along!(robot, Sud)), (side = Ost, num_steps = numsteps_along!(robot, West)), (side = Nord, num_steps = numsteps_along!(robot, Sud))
end

function numsteps_along!(robot, side)
    c = 0
    while !isborder(robot, side)
        move!(robot, side)
        c += 1
    end
    return c
end

function inverse(side)
    return HorizonSide(mod(Int(side) + 2, 4))
end

function mark_along!(robot, side)
    while !isborder(robot, side)
        putmarker!(robot)
        move!(robot, side)
    end
    putmarker!(robot)
end

function along!(robot, side, steps)
    for _ in 1:steps
        move!(robot, side)
    end
end

function move_back!(robot, home)
    for i in home
        along!(robot, i.side, i.num_steps)
    end
end

function external_perimetr!(robot)
    for side in (Ost, Nord, West, Sud)
        mark_along!(robot, side)
    end
end

function find_in_row!(robot, side) 
    while !isborder(robot, Nord) && !isborder(robot, side)
        move!(robot, side)
    end
end

function find_internal_border!(robot)
    side = Ost
    find_in_row!(robot, side)
    while !isborder(robot, Nord)
        move!(robot, Nord)
        side = inverse(side)
        find_in_row!(robot, side)
    end
end

function cool_internal_pos!(robot)
    while isborder(robot, Nord)
        move!(robot, West)
    end
    move!(robot, Ost)
end

function mark_along!(robot, side, left_side)
    while isborder(robot, left_side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function left(side)
    return HorizonSide(mod(Int(side) + 1, 4))
end 

function mark_internal_rect!(robot)
    for side in (Ost, Nord, West, Sud)
        putmarker!(robot)
        mark_along!(robot, side, left(side))
        move!(robot, left(side))
        putmarker!(robot)
    end
end