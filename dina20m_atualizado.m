clear; clc; close all;

%===|ARQUIVO A SER CARREGADO|===%
fid = fopen('C:\USP\BAJA\Eletronica\Teste_dina_motorNovo_17-02-2024\Passagem4.txt');
setupn = 0; %numero do setup

%===|Converte os dados do arquivo em Variaveis|===%
d = textscan(fid,'%s');
data = cat(1,d{:});
dataexpand = cellfun(@num2cell,data,'UniformOutput',false);
alldata = cat(1,dataexpand{:});

rpm = str2double(string(cell2mat(alldata(:,1:4))));
force = str2double(string(cell2mat(alldata(:,5:8))));
counter = str2double(string(cell2mat(alldata(:,9:12))));
%disp(max(rpm));

force = force./10;

%===|Aplica Média Movel nos dados|===%
counter = movmean(counter,1);
rpm = smoothdata(rpm,'gaussian',1500);
force = smoothdata(force,'gaussian',1500);

%===|Variaveis de pro calculo|===%
braco = 0.63; %mm
Patm = 1010; %mBar
Tatm = 26; %Celcius

%===|Fatores Calculo de Torque e Potencia|===%
torque = force * braco;
powerKW = torque .* rpm ./ 60000.0;
powerKW = powerKW .* 2 .* pi;
powerHP = powerKW ./ 0.745699872;
coef = 1.18 * ((990 / Patm) * ((273 + Tatm) / 298) ^ 0.5) - 0.18;
disp(coef);

figure ('Name','Dado x Tempo');
%plot(counter,'color',[0,0,0]);
hold on;
grid on;
plot(rpm,'color',[1,0,0]);
%plot(smoothdata(rpm,'gaussian',1500),'color',[0.5,0,0]);
plot(force*10,'color',[0,1,0]);
%plot(smoothdata(force,'gaussian',1500)*10,'color',[0,0.5,0]);
plot(torque*10,'color',[0,0,1]);
plot(powerHP*10,'color',[1,0,0.5]);
plot(powerKW*10,'color',[1,0,1]);
hold off;

xi = 4584;
xf = 17620;

figure ('Name','Resultado');
subplot(2,1,1);
hold on;
grid on;
yyaxis left;
plot(rpm(xi:xf),torque(xi:xf)./9.8,'color',[0,0,1],'linewidth',1);
yyaxis right;
plot(rpm(xi:xf), powerHP(xi:xf),'color',[1,0,0],'linewidth',1);
title('Potência e Torque');
legend('Torque (KgFm)','Potência (HP)','Location','northwest')
hold off;

subplot(2,1,2);
hold on;
grid on;
yyaxis left;
plot(rpm(xi:xf),torque(xi:xf)./9.8 *coef,'color',[0,0,1],'linewidth',1);
yyaxis right;
plot(rpm(xi:xf), powerHP(xi:xf) *coef,'color',[1,0,0],'linewidth',1);
title('Potência e Torque com Correcção Atmosférica');
legend('Torque (KgFm)','Potência (HP)','Location','northwest')
hold off;

disp('Maximo rpm e: ');
disp(max(rpm));
disp('A força maxima e (N):');
disp(max(force));
disp('O torque maximo e (Kgf):');
disp(max(torque)/9.8);
disp('A potencia maxima e (HP):');
disp(max(powerHP));
disp(max(powerHP*coef));