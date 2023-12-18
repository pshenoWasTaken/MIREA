using HorizonSideRobots
robot = Robot(animate = true)
inverse(side) = HorizonSide(mod(Int(side)+2, 4))

function num_borders!(robot)
    side = Ost
    N = 0
    n1, n2 = start!(robot)
    while !isborder(robot, Nord) || !isborder(robot, Ost)
        N += num_borders!(robot, side)
        if !isborder(robot, Nord)
            move!(robot, Nord)
        end
        side = inverse(side)
    end
    start!(robot)
    goback!(robot, n1, n2)
    return N-1        
end


function num_borders!(robot,side)
    num_b = 0
    flag = false 
    while !isborder(robot,side)
            if isborder(robot,Nord) && flag == false
                num_b += 1
                flag = !flag
            end
            if !isborder(robot,Nord)
                flag = false
            end
            move!(robot,side)
    end
    return num_b
end

function move_ifnoborder!(robot, side)
    num_s  = 0
    while !isborder(robot,side)
        move!(robot,side)
        num_s += 1
    end
    return num_s
end

function start!(robot::Robot)
    num_s1 = num_s2 = 0
    while !isborder(robot, Sud) || !isborder(robot,West)
        num_s1 += move_ifnoborder!(robot, Sud)
        num_s2 += move_ifnoborder!(robot, West)
    end
    return (num_s1, num_s2)
end

function goback!(robot, n1, n2)
    for _ in range(0, n1 - 1)
        move!(robot, Nord)
    end
    for _ in range(0, n2 - 1)
        move!(robot, Ost)
    end
end



println(num_borders!(robot))