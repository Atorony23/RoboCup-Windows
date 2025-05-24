function cesto_debasura = cesto(objeto)
    switch objeto
        case "Lata" | "SPAM" | "Verde" | "Rosa"
            % Bote verde
           cesto_debasura = 1;

        case "Botella" | "Tapa" | "Plumon" | "Rojo" | "Azul"
            % Bote azul
           cesto_debasura = 0;
    end
end

%0--Esta funcion nos servira para poder definir y seleccionar de manera
%automatica el valor del cesto, si queremos que sea cesto verde o azul

%1--Utilizamos un switch case que nos definira si es lata o spam o verde o
%rosa el objeto nos devolvera el cesto 1 (verde) o si es alguno de los
%otros objetos nos devolvera en el cesto 0 (azul)