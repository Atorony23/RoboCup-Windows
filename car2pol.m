function coci = car2pol(x,y,z)

    r = min(0.91,sqrt(x^2+y^2));
    theta = atan2(y,x);
    h_deseada = z;

    h_posible = min(h_deseada,sqrt((1-(r/0.89)^2)*0.9^2)); 
    % coordenadas_cilindricas(r,theta,h)
    coci = [r,theta,h_posible];
end

% function coci = car2pol(x,y,z)
% 
%     r = min(0.91,sqrt(x^2+y^2));
%     theta = atan2(y,x);
%     h_deseada = z;
% 
%     h_posible = min(h_deseada,sqrt((1-(r/0.91)^2)*0.6^2)); 
%     % coordenadas_cilindricas(r,theta,h)
%     coci = [r,theta,h_posible];
% end