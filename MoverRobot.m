function [jointAngles,H_Actual_Mesa]= MoverRobot(coci,angulo_Gripper,defase_Robot,jointAngles,ur,bandera)
%%%Manda la posicion del efector, en donde lo queremos, ocupamos darle los
% coci = coordenadas_cilindricas(r,theta,h)


    %Punto 3d que el usuario quiere alcanzar
    p_real = rah2p(coci);

    %Punto 3d que el robot quiere alcanzar
    p_robot = mi_Rotz(defase_Robot)*p_real;

    %Angulo necesario del Gripper para mantener una posición radial + el
    %ajuste del usuario
    temp = p2rah(p_robot);
    nuevo_Angulo_Gripper = temp(2) + angulo_Gripper + defase_Robot;

    %Se construye la matriz de transformación homogénea
    H_Actual_Robot = [RGrip(nuevo_Angulo_Gripper),p_robot;0 0 0 1];
    H_Actual_Mesa =  [0 -1 0 0; ...
                    1 0 0 0;...
                    0 0 1 0;
                    0 0 0 1] * H_Actual_Robot;

    %Aqui entramos con los datos de cinemtica inversa y datos anteriores
    %del posicion del cobot-----------------------------------------------
    jointAngles = InverseKinematicUR5eITESMTampico2025(H_Actual_Robot,jointAngles,bandera);
    
    % UR5econfig = [RobotConfiguration(3).JointPosition RobotConfiguration(2).JointPosition...
    % RobotConfiguration(1).JointPosition RobotConfiguration(4).JointPosition...
    % RobotConfiguration(5).JointPosition RobotConfiguration(6).JointPosition]; %Acomoda la informacion para que ROS lo entienda

     % UR5config = [jointAngles(3) jointAngles(2)...
     %     jointAngles(1) jointAngles(4)...
     %     jointAngles(5) jointAngles(6)];
    
    %Falta mandar los datos desde aqui (Falta acomodar)
    %jointWaypoints = jointAngles*pi/180;
    %[~,~] = sendJointConfigurationAndWait(ur,UR5config,'EndTime',10);
    [~,~] = sendJointConfigurationAndWait(ur,jointAngles,'EndTime',5);

    %Mandamos los datos por medio de ROS
    %trajGoal = packTrajGoal(UR5econfig,trajGoal); %Envia los datos por medio de ROS
    %sendGoal(trajAct,trajGoal);

    %jointStateMsg = receive(jointSub,3) 

    % q = zeros(6,1);
    % 
    %  while true
    %      jointStateMsg = readJointConfiguration(ur);
    %      q(1) = jointAngles(1) - jointStateMsg(1);
    %      q(2) = jointAngles(2) - jointStateMsg(2);
    %      q(3) = jointAngles(3) - jointStateMsg(3);
    %      q(4) = jointAngles(4) - jointStateMsg(4);
    %      q(5) = jointAngles(5) - jointStateMsg(5);
    %      q(6) = jointAngles(6) - jointStateMsg(6);
    %      if norm(q) < 0.1
    %          break
    %      end
    %  end

end

%Funciones locales del programa -------------------------------------------

function output = RGrip(AngGrip)
%Ingresa el angulo de rotación del griper, este siempre apunta con el eje z
%hacia abajo.
    output = [cos(AngGrip) sin(AngGrip) 0;...
             sin(AngGrip) -cos(AngGrip) 0;...
              0    0   -1];
end

function output = p2rah(p)
%Recibe un punto en coordenadas cartesianas y lo translada a coordenadas
%cilíndricas (x,y,z)-->(radio,angulo,altura)
    output = [norm([p(1),p(2)]); 
              atan2(p(2),p(1)) ;      
              p(3) ];
end

function output = rah2p(p)
%Recibe un punto en coordenadas cilíndricas y lo translada a coordenadas
% (radio,angulo,altura) --> (x,y,z)
    output = [p(1)*cos(p(2)) ;
              p(1)*sin(p(2)) ;
              p(3)];
end

function output = mi_Rotz(theta)
%Ingreso un ángulo en RADIANES y devuelve la respectiva matriz de rotación en z.
    output = [cos(theta) -sin(theta) 0;
              sin(theta) cos(theta) 0;
              0 0 1];
end

%-----Funcionamiento-----
%Esta funcion nos llevara a cualquier punto al que queramos llegar solo mandando las coordenadas para x, y, z (Este lo podemos utilizar para todo)
%Esta es una funcion a la cual, nos llevara a la primera botella, a ella le estamos mandando una Robot config, el trajGoal, trajAct y el peso de los motores.
%La misma funcion ya cuenta con las coordenadas del bote de basura, asi que hace la tranformada homogenea, para el calulo de los movimientos que debe de hacer.
%Al final termina mandando los datos por medio de la UR5econfig
%NOTA: Podemos cambiar y agregar los valores en los que recibe y por ende, cambiar la orientacion del gripper

%%%
%gorienZ,gorienY,gorienX
%gripperRotation = [gorienZ gorienY gorienX];