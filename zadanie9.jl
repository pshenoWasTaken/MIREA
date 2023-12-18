using HorizonSideRobots
r = Robot(animate = true)


function chess(r)
    v, g = start!(r, Sud, West)
    if mod(v, 2) == mod(g, 2)
        putmarker!(r)
    end
    mark_field!(r, Ost, Nord)
    start!(r, Sud, West)
    some_moves!(r, Nord, v)
    some_moves!(r, Ost, g)
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function some_moves!(r, side, n)
    for i in 1:n
        move!(r, side)
    end
end

function mark_field!(r, side1, side2)
    while !isborder(r, side2)
        mark_along!(r, side1)
        if ismarker(r)
            move!(r, side2)
        else
            move!(r, side2)
            putmarker!(r)
        end
        side1 = inverse(side1)
    end
    mark_along!(r, side1)
end

function mark_or_not(r, f)
    if f == true
        putmarker!(r)
        f = false
    else
        f = true
    end
    return f
end

function mark_along!(r, s)
    if !ismarker(r)
        move!(r, s)
        putmarker!(r)
    else
        f = true
    end
    f = false
    while !isborder(r, s)
        move!(r, s)
        f = mark_or_not(r, f)
    end
end


function start!(r, side1, side2)
    steps1, steps2 = 0, 0
    while !(isborder(r, side1) & isborder(r, side2))
        if !isborder(r, side1)
            move!(r, side1)
            steps1 += 1
        end    
        if !isborder(r, side2)
            move!(r, side2) 
            steps2 += 1
        end  
    end 
    return steps1, steps2
end

