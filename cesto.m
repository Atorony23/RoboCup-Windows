function cesto_debasura = cesto(objeto)
    if ismember(objeto, ["Lata", "SPAM", "Verde", "Rosa"])
        % Bote verde
        cesto_debasura = 1;
    elseif ismember(objeto, ["Botella", "Tapa", "Plumon", "Rojo", "Azul"])
        % Bote azul
        cesto_debasura = 0;
    else
        error('Objeto no reconocido');
    end
end
