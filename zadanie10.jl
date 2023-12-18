using HorizonSideRobots
r = Robot(animate=true) 

k = parse(Int, readline())

function chess!(r, n)
    v, g = start!(r, Sud, West)
    putmarker!(r)
    square!(r, Ost, Nord, n)
    move_along!(r, West)
    some_moves!(r, Nord, v)
    some_moves!(r, Ost, g)
end

function square!(r, side1, side2, n)
    mark_along!(r, side1, n)
    while !isborder(r, side1)
        mark_along!(r, side2, n)
        move!(r, side1)
    end
    mark_along!(r, side2, n)
end

function mark_along!(r, s, n)
    if ismarker(r)
        mark_some_moves!(r, s, n-1)
        while !isborder(r, s)
            some_moves!(r, s, n)
            mark_some_moves!(r, s, n)
        end
    else
        some_moves!(r, s, n-1)
        while !isborder(r, s)
            mark_some_moves!(r, s, n)
            some_moves!(r, s, n)
        end
    end
    move_along!(r, inverse(s))
end

function start!(r, side1, side2)
    n1, n2 = 0, 0
    while !(isborder(r, side1) & isborder(r, side2))
        if ! isborder(r, side1)
            move!(r, side1)
            n1 += 1
        end    
        if ! isborder(r, side2)
            move!(r, side2) 
            n2 += 1
        end  
    end 
    return n1, n2
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function some_moves!(r, side, n)
    for i in 1:n
        if !isborder(r, side)
            move!(r, side)
        end
    end
end

function mark_some_moves!(r, side, n)
    for i in 1:n
        if !isborder(r, side)
            move!(r, side)
            putmarker!(r)
        end
    end
end

function move_along!(r, s)
    while !isborder(r, s)
        move!(r, s)
    end
end

chess!(r, k)