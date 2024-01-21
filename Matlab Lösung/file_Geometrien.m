
% Lade die gemeinsamen Variablen
%load('shared_variables.mat', 'M', 'pa', 'pi', 'Kreise');

%Struct_Geometrien = struct('Wanddicke', 0.2,... % Wanddicke in m
    %'Aussenradius', 1 ,...  % �u�erer Radius in m
    %'Innenradius', .5);    % innerer Radius in m


% Extrahiere Werte aus Struct_Geometrien und weise sie Variablen zu
e = Struct_Geometrien.Wanddicke;
ra = Struct_Geometrien.Aussenradius;
ri = Struct_Geometrien.Innenradius;



% �berpr�fe Bedingungen basierend auf M, ri und anderen Variablen
if M ~= 0
    % �berpr�fe zus�tzliche Bedingung wenn ri = 0
    if ri == 0
        % �berpr�fe die Annahme: e << ra
        if e <  ra  % Angepasster Faktor
            fprintf('Geeignet f�r Kreisplatte\n');
            Kreise = 2;  % Setze Kreise auf 2, wenn geeignet f�r eine Kreisplatte
        else
            fprintf('Annahme nicht erf�llt: e ist nicht deutlich kleiner als ra\n');
        end
    else
        % Option 1: Kreisring
        if 1 < ri/ra && ri/ra <= 1.25
            fprintf('Geeignet f�r Kreisring\n');
            Kreise = 3;  % Setze Kreise auf 3, wenn geeignet f�r Kreisring
        else
            % Option 2: Teste Kreisplatte
            % �berpr�fe die Annahme: e << ra
            if e < ra  % Angepasster Faktor
                fprintf('Geeignet f�r Kreisplatte\n');
                Kreise = 2;  % Setze Kreise auf 2, wenn geeignet f�r Kreisplatte
            else
                fprintf('Keine geeigneten Kreise f�r Ihr System\n');
            end
        end
    end
end

disp(['Kreise = ' num2str(Kreise)]);

% Save the result
save('shared_variables.mat', 'Kreise', '-append');
