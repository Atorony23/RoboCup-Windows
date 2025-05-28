function [jointAngles,coci]=bote(angulo_Gripper,defase_Robot,jointAngles,ur,bandera)
    %Se movera sobre el bote
    pb = [-0.58*(-1)^bandera,0.1]; %coord xy del bote >>>>>>------CAMBIAR----------<<<<<<<
    coci = car2pol(pb(1),pb(2),0.3);
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    pause(2.5)
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2.5)
end