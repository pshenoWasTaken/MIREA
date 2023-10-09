using HorizonSideRobots
r = Robot(animate = true)

inverse(side) = HorizonSide(mod(Int(side)+2,4)) 
nextside(side) = HorizonSide(mod(Int(side)+1,4)) 
prevside(side) = HorizonSide(mod(Int(side)-1,4)) 

function markers() 
    t = pos_Sud_Ost() 
    marking_outside_border(Nord) 
    move_inverse(t) 
end 

function pos_Sud_Ost() 
    moves = [] 
    while !isborder(r, Sud) || !isborder(r, Ost) 
        if isborder(r, Sud) 
            move!(r, Ost) 
            push!(moves, Ost) 
        else 
            move!(r, Sud) 
            push!(moves, Sud) 
        end 
    end 
    return reverse(moves) 
end 

function marking_outside_border(side) 
    for i in 1:4 
        while !isborder(r, side) 
            move!(r, side) 
            putmarker!(r) 
        end 
        side = nextside(side) 
    end 
end 

function move_inverse(move) 
    for i in move 
        move!(r, inverse(i)) 
    end 
end 
