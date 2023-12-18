using HorizonSideRobots
r = Robot(animate = true)

function shuttle!(stop_condition, r, direct1)
    k = 1
    while stop_condition(r, Nord)
        along!(r, direct1, k)
        direct1 = inverse(direct1)
        k += 1
    end
end

function along!(robot, direct, num_steps)
    for _ in 1:num_steps
        move!(robot, direct)
    end
end

inverse(side) = HorizonSide(mod(Int(side)+2, 4))

shuttle!(isborder, r, Ost)