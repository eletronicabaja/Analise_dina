function [powerHP, rpm, torque] = get_dina_data(path)
fid = fopen(path);
setupn = 0; %numero do setup

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rpm = str2double(string(cell2mat(alldata(:,1:4))));
force = str2double(string(cell2mat(alldata(:,5:8))));
counter = str2double(string(cell2mat(alldata(:,9:12))));

%===|Aplica Média Movel nos dados|===%
counter = movmean(counter,1);
rpm = smoothdata(rpm,'gaussian',1500);
force = smoothdata(force,'gaussian',1500);

force = force./10;

%===|Variaveis de pro calculo|===%
braco = 0.64; %mm
Patm = 1015; %mBar
Tatm = 29; %Celcius

%===|Fatores Calculo de Torque e Potencia|===%
torque = force * braco;
powerKW = torque .* rpm ./ 60000.0;
powerKW = powerKW .* 2 .* pi;
powerHP = powerKW ./ 0.745699872;
coef = 1.18 * ((990 / Patm) * ((273 + Tatm) / 298) ^ 0.5) - 0.18;

end