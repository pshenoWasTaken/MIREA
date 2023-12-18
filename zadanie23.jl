using HorizonSideRobots
r = Robot(animate = true) 

inverse(s) = HorizonSide(mod(Int(s) + 2, 4))

next(s) = HorizonSide(mod(Int(s) + 1, 4))

function simmetr!(r, side, steps)
    if !isborder(r, side)
        try_move!(r, side)
        steps += 1
        steps += simmetr!(r, side, steps)
        return steps
    else
        move_on!(r, side, 0)
        try_move!(r, side, steps)
        return 0
    end
end

function move_on!(r, side, steps)
    ort = next(side)
    if try_move!(r, side)
        for i in 1:(steps)
            move!(r, inverse(ort))
        end
    else
        if isborder(r, side)
            move!(r, ort)
            steps += 1
            x = move_on!(r, side, steps)
            steps += x
            return steps
        end
    end
    return 0
end

function try_move!(r, side)
    if !isborder(r, side) 
        move!(r, side)
        return true
    else 
        return false
    end
end

function try_move!(r, s, num)
    for i in 1:num
        try_move!(r, s)
    end
end


simmetr!(r, Ost, 0)