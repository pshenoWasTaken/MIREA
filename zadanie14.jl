using HorizonSideRobots
rob = Robot(animate = true) 

function chess!(r)
    p = start_put!(r, Nord, Ost)
    v, g = start_col!(r, Sud, West)
    if mod(v + count(p, "0"), 2) == mod(g + count(p, "1"), 2)
        putmarker!(r)
    end
    mark_along!(r, Nord, v)
    mark_along!(r, Ost, g)
    mark_along!(r, Sud, v)
    mark_field!(r, West, Nord, v, g)
    start_put!(r, Nord, Ost)
    go_back!(r, Sud, West, p)
end

function mark_field!(r, s, osn, vis, shir)
    t = 1
    while t < vis
       mark_along!(r, s, shir)
       s = inverse(s)
       move!(r, osn)
       t += 1
    end
end

function mark_along!(r, s, shir)
    t = 1
    if ismarker(r)
        shir -= 1
        move!(r, s)
    end
    stav!(r, t)
    while t < shir
        t += wall(r, s, 0, 0)[2]
        stav!(r, t)
    end
    if shir != t
        move!(r, s)
        stav!(r, t)
    end
end

function stav!(r, t)
    if mod(t, 2) == 0
        putmarker!(r)
    end
end

function start_col!(r, side1, side2)
    n1, n2 = 1, 1
    while !(isborder(r, side1) & isborder(r, side2))
        if !isborder(r, side1)
            move!(r, side1)
            n1 += 1
        end    
        if !isborder(r, side2)
            move!(r, side2)
            n2 += 1
        end  
    end
    return n1, n2
end

function start_put!(r, side1, side2)
    p = ""
    while !(isborder(r, side1) & isborder(r, side2))
        if !isborder(r, side1)
            move!(r, side1)
            p *= "0"
        end    
        if ! isborder(r, side2)
            move!(r, side2)
            p *= "1"
        end  
    end
    return p
end

function go_back!(r, side1, side2, p::String)
    p = reverse(p)
    for i in p
        if i == '0'
            move!(r, side1)
        else
            move!(r, side2)
        end
    end
end

function wall(r, side, steps, steps2)
    ort = next(side)
    if try_move!(r, side)
        steps2 += 1
        if !isborder(r, inverse(ort))
            for i in 1:(steps)
                move!(r, inverse(ort))
            end
            return steps, steps2
        else
            if steps == 0
                return (0, 1) 
            end
            steps, steps2 = wall(r, side, steps, steps2)
        end
        return (steps, steps2)
    else
        if isborder(r, side)
            move!(r, ort)
            x, y = wall(r, side, steps + 1, steps2)
            steps = x
            steps2 = y
            return (steps, steps2)
        end
    end
end

function try_move!(r, side)
    if !isborder(r, side) 
        move!(r, side)
        return true
    else 
        return false
    end
end

function some_moves!(r, side, n)
    for i in 1:n
        try_move!(r, side)
    end
end

function inverse(s)
    return HorizonSide(mod(Int(s) + 2, 4))
end

function next(s)
    return HorizonSide(mod(Int(s) + 1, 4))
end

chess!(rob)