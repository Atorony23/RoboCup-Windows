function [jointAngles,coci]=bascula(coci,angulo_Gripper,defase_Robot,jointAngles,ur,gripp)
    %Hara que suba sobre el mismo punto
    h_deseada = 0.30;
    h_posible = min(h_deseada,sqrt((1-(coci(1)/0.91)^2)*0.6^2));  
    coci = [coci(1),coci(2),h_posible]; 
    jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
    
    %Se movera sobre la bascula
    puntosBasc = [0, 0.35, -0.06+0.30]; %coord xyz de la bascula>>>>>------CAMBIAR------<<<<<<<
    n = 0.300;
    for e=1:1:4
        coci = car2pol(puntosBasc(1),puntosBasc(2),-0.06+n);
        jointAngles = MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur);
        pause(0.25)
        n = n-0.100;
    end
    %Abre el gripper
    actuateGripper(ur,'release');
    pause(2)

    %Cerramos gripper
    actuateGripperH(ur,jointAngles,gripp);
end