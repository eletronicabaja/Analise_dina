[power1,rpm1,torque1] = get_dina_data('C:\USP\BAJA\Eletronica\Teste_dina_motorNovo_17-02-2024\Passagem1.txt');
[power2,rpm2,torque2] = get_dina_data('C:\USP\BAJA\Eletronica\Teste_dina_motorNovo_17-02-2024\Passagem2.txt');
[power3,rpm3,torque3] = get_dina_data('C:\USP\BAJA\Eletronica\Teste_dina_motorNovo_17-02-2024\Passagem3.txt');
[power4,rpm4,torque4] = get_dina_data('C:\USP\BAJA\Eletronica\Teste_dina_motorNovo_17-02-2024\Passagem4.txt');

xi1 = 225;
xf1 = 7903;

xi2 = 4514;
xf2 = 18489;

xi3 = 4892;
xf3 = 16792;

xi4 = 3206;
xf4 = 29069;

figure ('Name','Resultado');
subplot(2,1,1);
hold on;
grid on;
yyaxis left;
plot(rpm1(xi1:xf1),torque1(xi1:xf1)/9.8,'color',[0,0,1],'linewidth',2);
%plot(rpm1(xi2:xf2),power2(xi2:xf2)*10./9.8,'color',[0,1,1],'linewidth',2);
%plot(rpm3(xi3:xf3),torque3(xi3:xf3)./9.8,'color',[0,1,0],'linewidth',2);
plot(rpm4(xi4:xf4),torque4(xi4:xf4)/9.8,'color','black','linewidth',2);

yyaxis right;
plot(rpm1(xi1:xf1),power1(xi1:xf1),'r-','color',[1,0,0],'linewidth',2);
%plot(rpm2(xi2:xf2),power2(xi2:xf2)./9.8,'color',[0,1,1],'linewidth',1);
%plot(rpm3(xi3:xf3),power3(xi3:xf3)./9.8,'color',[1,0,1],'linewidth',1);
plot(rpm4(xi4:xf4),power4(xi4:xf4),'color',[0,1,0],'linewidth',2);

%title('Torque (kgfm) e Potencia (HP) com correção Atmosféfica');
%legend('Torque Setup 1','Torque Setup 2','Potência Setup 1','Potência Setup 2')
hold off;


%figure ('Name','Resultado');
%subplot(2,1,1);
%hold on;
%grid on;
%yyaxis left;
%plot(rpm1(xi1:xf1),power1(xi1:xf1)./9.8,'color',[0,0,1],'linewidth',1);
%plot(rpm1(xi2:xf2),power2(xi2:xf2)./9.8,'color',[0,1,1],'linewidth',1);
%plot(rpm1(xi3:xf3),power3(xi3:xf3)./9.8,'color',[1,0,1],'linewidth',1);
%plot(rpm1(xi4:xf4),power4(xi4:xf4)./9.8,'color',[1,1,1],'linewidth',1);
%title('Potência com correção Atmosféfica');
%legend('Torque (kg)', 'Potência (HP)','Location','northwest')
%hold off;


