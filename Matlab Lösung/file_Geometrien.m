
% Lade die gemeinsamen Variablen
%load('shared_variables.mat', 'M', 'pa', 'pi', 'Kreise');

%Struct_Geometrien = struct('Wanddicke', 0.2,... % Wanddicke in m
    %'Aussenradius', 1 ,...  % äußerer Radius in m
    %'Innenradius', .5);    % innerer Radius in m


% Extrahiere Werte aus Struct_Geometrien und weise sie Variablen zu
e = Struct_Geometrien.Wanddicke;
ra = Struct_Geometrien.Aussenradius;
ri = Struct_Geometrien.Innenradius;



% Überprüfe Bedingungen basierend auf M, ri und anderen Variablen
if M ~= 0
    % Überprüfe zusätzliche Bedingung wenn ri = 0
    if ri == 0
        % Überprüfe die Annahme: e << ra
        if e <  ra  % Angepasster Faktor
            fprintf('Geeignet für Kreisplatte\n');
            Kreise = 2;  % Setze Kreise auf 2, wenn geeignet für eine Kreisplatte
        else
            fprintf('Annahme nicht erfüllt: e ist nicht deutlich kleiner als ra\n');
        end
    else
        % Option 1: Kreisring
        if 1 < ri/ra && ri/ra <= 1.25
            fprintf('Geeignet für Kreisring\n');
            Kreise = 3;  % Setze Kreise auf 3, wenn geeignet für Kreisring
        else
            % Option 2: Teste Kreisplatte
            % Überprüfe die Annahme: e << ra
            if e < ra  % Angepasster Faktor
                fprintf('Geeignet für Kreisplatte\n');
                Kreise = 2;  % Setze Kreise auf 2, wenn geeignet für Kreisplatte
            else
                fprintf('Keine geeigneten Kreise für Ihr System\n');
            end
        end
    end
end

disp(['Kreise = ' num2str(Kreise)]);

% Save the result
save('shared_variables.mat', 'Kreise', '-append');
