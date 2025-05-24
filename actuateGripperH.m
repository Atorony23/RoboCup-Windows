function actuateGripperH(ur,jointAngles,cerrado)
    sendJointConfigurationAndWait(ur,jointAngles,"EndTime",5,"Velocity",cerrado) %1
    pause(0.5) %2
    actuateGripper(ur,"grip") %3
end

    
%0--%Esta funcion esta diseñada para el poder tener un control de clausura
    %por mm del gripper durante el control del cobot fisico. (50 mm a 0.1
    %mm)

%1--%Iniciamos utilizando la misma funcion de envío de configuracion de
    %juntas, cambiando el valor de velocidad (Algo para tener en
    %consideracion es que el valor que estamos mandando dentro de la
    %funcion en realidad no tiene relacion alguna con el control de la
    %velocidad del cobot, dentro del script del cobot se realizaron unas
    %mdificaciones para los registros, lo que nos permite actualmente el
    %poder mandar un valor global para la clausura precisa del gripper)

%2--%Realizamos una pausa de 0.5 seg

%3--%Mandamos a activar la funcion de actuateGripper para que se ejecute en
    %el script del cobot, el cual se modifico para que tuviera el valor
    %asignado en el registro de "Veloicity" actualmente llamado "posee" y
    %con la funcion rq_move_and_wait_mm(posee,3), asignamos los valores
    %necesarios para ello