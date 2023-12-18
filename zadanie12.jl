using HorizonSideRobots
robot = Robot(animate = true)
inverse(side) = HorizonSide(mod(Int(side)+2, 4))

function num_borders!(robot)
    side = Ost
    N = 0
    n_nord, n_ost = start!(robot,Sud,West)
    while !isborder(robot,Nord) || !isborder(robot,Ost)
        N += num_borders!(robot,side,Nord)
        if !isborder(robot,Nord)
            move!(robot,Nord)
        end
        side = inverse(side)
    end
    start!(robot, Sud, West)
    goback!(robot, n_nord, n_ost)

    return N-1  
end

function num_borders!(robot, move_side, check_side)
    num_b = 0
    flag = 0 
    while !isborder(robot,move_side)
        if flag == 0
            if isborder(robot,check_side)
                num_b += 1
                flag = 1
            end
        elseif flag == 1
            if isborder(robot,check_side)
                flag = 1
            else
                flag = 2
            end
        elseif flag == 2
            if isborder(robot,check_side)
                flag = 1
            else
                flag = 0
            end
        end
        move!(robot,move_side)
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

function start!(robot, side1, side2)
    num_s1 = num_s2 = 0
    while !isborder(robot, side1) || !isborder(robot,side2)
        num_s1 += move_ifnoborder!(robot,side1)
        num_s2 += move_ifnoborder!(robot,side2)
    end
    return (num_s1, num_s2)
end

function goback!(robot::Robot, n_1::Int, n_2::Int)
    for _ in range(0,n_1-1)
        move!(robot, Nord)
    end
    for _ in range(0,n_2-1)
        move!(robot,Ost)
    end
end



println(num_borders!(robot))