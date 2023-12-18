using HorizonSideRobots
r = Robot(animate = true) 

inverse(s) = HorizonSide(mod(Int(s) + 2, 4))

next(s) = HorizonSide(mod(Int(s) + 1, 4))

function wall(r, side, steps = 0)
    ort = next(side)
    if try_move!(r, side)
        move!(r, inverse(ort), steps)
    else
        if isborder(r, side)
            move!(r, ort)
            steps += 1
            x = wall(r, side, steps)
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

function HorizonSideRobots.move!(r, s, num)
    for i in 1:num
        move!(r, s)
    end
end


