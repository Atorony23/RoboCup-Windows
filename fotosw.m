function img = fotosw()
    httpsUrl = "http://192.168.1.10:4242"; %1
    imageUrlf = strcat(httpsUrl, "/current.jpg?annotations=on"); %2
    imageUrln = strcat(httpsUrl, "/current.jpg?annotations=off"); %2
    imageFile = "computerf.jpg"; %3
    imageFileFullPathf = websave(imageFile, imageUrlf); %3
    img = "computern.jpg"; %4
    imageFileFullPathn = websave(img, imageUrln); %4
    img = imread(img); %5
end

%0--Esta funcion nos permite capturar una imagen por medio de la direccion
    %IP y una pagina web, lo que permite que lo hagamos sin necesidad de ROS
    %como tal

%1--Por medio de codificacion de Matlab, declaramos y guardamos el valor
%"https" del URL, aqui debemos de modificar la direccion IP en caso de que
%esta se modifique en el cobot, sería el unico valor a modificar
%"192.168.1.10", el otro valor con el que contamos es el valor del canal
%que en este caso es "4242", este valor lo podemos dejar de esta forma.

%2--Por consiguiente contamos con la misma linea de codigo pero con unas
%diferencias, principalmente, en donde guardamos el valor de la proxima
%parte del URL, ya que este URL completo es el siguiente
%"http://192.168.1.10:4242/current.jpg?annotations=<on=off>" pero al
%momento en que quisieramos guardar esta imagen causa que sobreescriba la
%imagen causando un delay en la descarga, lo que hacemos al separar el link
%URL con una seccion de "off" y "on", es que guardamos la imagen anterior
%"off" primero y despues la imagen "buena" que se encuentra en "on" la
%podemos recibir y guardar correctamente

%3--En esta seccion primeor guardamos la imagen con un nombre en una
%variable para despues utilizarla para poder guardar la imagen desde la
%direccion IP que le dimos anteriormente

%4--Realizamos lo mismo que en el paso anterior, con la modificacion de que
%la guardamos en una varible que despues utilizaremos

%5--Con la imagen guardada en la variable img, esta la sobrescribimos para
%poder mandarla de regreso fuera de la funcion, esta guardada en la
%variable img