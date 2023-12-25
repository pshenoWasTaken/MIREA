using HorizonSideRobots
HSR = HorizonSideRobots

left(side) = HorizonSide(mod(Int(side) + 3, 4))

mutable struct CountRobot 
    robot::Robot
    count::Integer
end

function HSR.move!(robot::CountRobot, side)
    move!(robot.robot, side)
    if ismarker(robot)
        robot.count += 1 
    end
end

robot = Robot(animate=true)
count_markers_robot = CountRobot(robot, ismarker(robot)) 


HSR.isborder(robot::CountRobot, side) = isborder(robot.robot, side)
HSR.putmarker!(robot::CountRobot) = putmarker!(robot.robot)
HSR.ismarker(robot::CountRobot) = ismarker(robot.robot)
HSR.temperature(robot::CountRobot) = temperature(robot.robot)


function spiral!(robot::CountRobot)
    side = Nord
    max_num_steps = 1
    while robot.count != 5
        num_steps = 0
        while num_steps < max_num_steps && robot.count != 5
            move!(robot::CountRobot, side)
            num_steps += 1
        end
        side = left(side)
        num_steps = 0
        while num_steps < max_num_steps && robot.count != 5
            move!(robot::CountRobot, side)
            num_steps += 1
        end
        max_num_steps += 1
        side = left(side)
    end
end

function stop(robot::CountRobot)
    if robot.count != 5
        return false
    else
        return true
    end
end