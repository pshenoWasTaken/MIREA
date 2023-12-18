using HorizonSideRobots
r = Robot(animate = true) 

function num_steps_along!(r, side)
    if isborder(r, side)
        return 0
    else
        move!(r, side)
        return num_steps_along!(r, side) + 1
    end
end

function try_move!(r, side, num_steps_max)
    if num_steps_max > 0
        if isborder(r, side)
            return num_steps_max
        end
        move!(r, side)
        return try_move!(r, side, num_steps_max - 1)
    else
        return 0
    end
end

inverse(side) = HorizonSide(mod(Int(side) + 2, 4))

function double_dist!(r, side)
    steps = num_steps_along!(r, side)
    rem_steps = try_move!(r, inverse(side), 2 * steps)
    if rem_steps == 0
        return true
    else
        try_move!(r, side, steps - rem_steps)
        return false
    end
end