
% Run file_Geometrien.m to define additional variables

%Struct_Werkstoff = struct('Werkstoff', 'Stahlguss',...
    %'Elastizitaetsmodul', 210000, ... % Elastizitätsmodul E in N/mm^2
    %'Querkontraktionszahl', 0.3, ... % Querkontraktionszahl v ist dimensionslos
    %'Festigkeitskennwert', 210, ... % Festigkeitskennwert K in N/mm^2
    %'Sicherheitsbeiwert', 2);       % Sicherheitsbeiwert S [-]


% Umbenennen der Variablen
E = Struct_Werkstoff.Elastizitaetsmodul;
v = Struct_Werkstoff.Querkontraktionszahl;
K = Struct_Werkstoff.Festigkeitskennwert;
S = Struct_Werkstoff.Sicherheitsbeiwert;




% Zusätzliche Anweisungen

if Kreise == 1
    % Schreibe die Gleichung für sigma_v
    sigma_v = abs(-2 * ra^2 * pi / (ri^2 - ra^2));
    
    % Zeige die Gleichung an
    disp('Gleichung für sigma_v:');
    disp(sigma_v);
    
    % Berechne K basierend auf der gegebenen Formel
    % Wir können also k mit diese Gleichung brechnen
    % K = pi * ri^2 / (ri^2 - ra^2);  
    
    % Zeige die Werte von sigma_v und K an
    disp(['sigma_v = ' num2str(sigma_v)]);
    disp(['K = ' num2str(K)]);
    
    % Überprüfe die Bedingung und zeige das Ergebnis an
    if sigma_v <= K / S
        disp('Behälter ist ausreichend gegen die reine Innenüberdruckbeanspruchung ausgelegt.');
    else
        disp('Behälter ist nicht ausreichend gegen die reine Innenüberdruckbeanspruchung ausgelegt.');
    end
    
elseif Kreise == 2
    % Berechne Biegesteifigkeit B
    B = (E * e^3) / (12 * (1 - v^2));
    
    % Zeige Biegesteifigkeit an
    disp(['Biegesteifigkeit = ' num2str(B)]);
    
    % Annahme: r ist ein numerischer Vektor von 0 bis ra
    r = linspace(0, ra, 100);  % Anzahl der Punkte anpassen, falls erforderlich
    
    % Definiere Funktion für w
    w = pa / (64 * B) * (r.^2 - ra^2).^2;  % Element-wise squaring using .^
    % Zeige die Funktion für w an
    disp(['Durchbiegung = ' num2str(w)]);
    
    % Plotte w über den Radius r
    plot(r, w, 'DisplayName', 'w');
    title('Biegesteifigkeit über den Radius r');
    xlabel('Radius r');
    ylabel('w');
    legend;

    sigma_v = abs(-2 * ra^2 * pi / (ri^2 - ra^2));

    
    % Zeige sigma_v an
    disp(['sigma_v = ' num2str(sigma_v)]);
    
    % Überprüfe die Bedingung und zeige das Ergebnis an
    if sigma_v <= K / S
        disp('Die Platte ist ausreichend dimensioniert!');
    else
        disp('Die Platte ist nicht ausreichend dimensioniert!');
    end
    
elseif Kreise == 3
    % Zusätzliche Berechnungen für Kreise == 3
    r0 = (ra + ri) / 2;
    A = (ra - ri) * e;  
    I = (ra - ri) * e^3 / 12;
    alpha = (M * r0^2) / (E * I);
    disp(['Verdrehwinkel α = ' num2str(alpha)]);
    
    F = pi * e * (ri / r0);
    disp(['Linienkraft = ' num2str(F)]);
    
    u = (F * r0^2) / (E * A);
    disp(['Radiale Verschiebung = ' num2str(u)]);

end
