using HorizonSideRobots
r = Robot(animate=true) 

function chess!(r)
    v, g = start!(r, Sud, West)
    if mod(v, 2) == mod(g, 2)
        putmarker!(r)
    end
    mark_field!(() -> isborder(r, Nord),r, Ost, Nord)
    start!(r, Sud, West)
    some_moves!(r, Nord, v)
    some_moves!(r, Ost, g)
end

function mark_field!(st_cond, r, side1, side2)
    while !st_cond()
        mark_along!(() -> isborder(r, side1), r, side1)
        if ismarker(r)
            move!(r, side2)
        else
            move!(r, side2)
            putmarker!(r)
        end
        side1 = inverse(side1)
    end
    mark_along!(() -> isborder(r, side1), r, side1)
end

function mark_along!(st_cond, r, s)
    if !ismarker(r)
        move!(r, s)
        putmarker!(r)
    else
        f = 1
    end
    f = 0
    while !st_cond()
        move!(r, s)
        f = mark_or_no!(r, f)
    end
end

function mark_or_no!(r, f)
    if f == 1
        putmarker!(r)
        f = 0
    else
        f = 1
    end
    return f
end

function start!(r, side1, side2)
    n1 = numsteps_along!(() -> isborder(r, side1), r, side1)
    n2 = numsteps_along!(() -> isborder(r, side2), r, side2)
    return n1, n2
end

function numsteps_along!(st_cond, r, side)
    n = 0
    while !st_cond()
        move!(r, side)
        n += 1
    end
    return n
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2,4))
end

function some_moves!(r, side, n)
    for i in 1:n
        move!(r, side)
    end
end

chess!(r)