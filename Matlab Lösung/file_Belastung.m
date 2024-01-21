 
        %Struct_Belastung = struct('Innendruck', 1, ... % Druck in bar
        %'Aussendruck', 1, ... % Druck in bar
        %'Moment', 1000); % Radialmoment in N, resultiert aus Verschraubungen

  
    % Extrahiere Werte aus der Struktur
    pa = Struct_Belastung.Aussendruck;   % Außendruck
    pi = Struct_Belastung.Innendruck;    % Innendruck
    M = Struct_Belastung.Moment;         % Radialmoment
    
% Initialisiere Kreise-Variable
Kreise = 0;

% Save relevant variables to pass to the second file
save('shared_variables.mat', 'M', 'pa', 'pi',"Kreise");

% Überprüfe Bedingungen basierend auf M, pa und pi
if M == 0
    % Speichere die Gleichung für spätere Verwendung
    equation = 'd/dz = 0';
    save('equation.mat', 'equation');
    
    % Überprüfe Bedingung 1.1
    if pa == pi
        fprintf('Kreisscheibe möglich\n');
        Kreise = 1;  % Setze Kreise auf 1, um später anzuzeigen, dass ein Kreis möglich ist

        % Rufe die zweite Datei auf
        file_Werkstoff;

    elseif pa ~= pi
        fprintf('Alle Kreise ebene nicht passende für dein System\n');
    end
else  
    % Rufe die zweite Datei auf
    file_Geometrien;
 % Rufe die zweite Datei auf
    file_Werkstoff;

end

disp(['Kreise = ' num2str(Kreise)]);
% Save the value of Kreise for use in the third file
save('shared_variables.mat', 'Kreise', '-append');