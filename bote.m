function [jointAngles,coci]=bote(coci,angulo_Gripper,defase_Robot,jointAngles,ur,bandera)
    %Hara que suba sobre el mismo punto
    h_deseada = 0.30;
    h_posible = min(h_deseada,sqrt((1-(coci(1)/0.91)^2)*0.6^2));  
    coci = [coci(1),coci(2),h_posible]; 
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    
    %Se movera sobre el bote
    pb = [-0.46,-0.5*(-1)^bandera]; %coord xy del bote >>>>>>------CAMBIAR----------<<<<<<<
    coci = car2pol(pb(1),pb(2),h_deseada);
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    pause(1)
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2)

end