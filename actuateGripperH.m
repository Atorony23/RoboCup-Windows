function actuateGripperH(ur,jointAngles,cerrado)
    sendJointConfigurationAndWait(ur,jointAngles,"EndTime",5,"Velocity",cerrado)
    pause(0.5)
    actuateGripper(ur,"grip")    
end
