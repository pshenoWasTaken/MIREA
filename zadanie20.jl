using HorizonSideRobots
r = Robot(animate = true)

inverse(s::HorizonSide) = HorizonSide(mod(Int(s)+2, 4))


function mark_and_return!(r, side)
    if isborder(r, side)
        putmarker!(r)
        return 
    end
    move!(r, side)
    mark_and_return!(r, side)
    move!(r, inverse(side))
end
