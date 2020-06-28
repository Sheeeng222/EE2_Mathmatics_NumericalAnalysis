clear all, format long e,  
% solving the equation Ly'+Ry=3.5. 
% where y= i, x = t, L=0.0015, R=0.5;  
clear xi yi err yexact N, 

xi=0;
ii=0;
R=0.5;
xf1=0.000016;
xf2=0.00016;
xf3=0.00045;
xf4=0.0012;
h1=0.0000005;
h2=0.000005;
h3=0.000015;
h4=0.00004;
f1=66666.6;
f2=6666.6;
f3=2500;
f4=909.09;
% --------sine wave----------------------------------
Vin1=@(x) 4*sin(2*pi*f1*x);
func1=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f1*x);
Vin2=@(x) 4*sin(2*pi*f2*x);
func2=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f2*x);
Vin3=@(x) 4*sin(2*pi*f3*x);
func3=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f3*x);
Vin4=@(x) 4*sin(2*pi*f4*x);
func4=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f4*x);
% --------square wave--------------------------------
% Vin1=@(x) 4*square(2*pi*f1*x);
% func1=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f1*x);
% Vin2=@(x) 4*square(2*pi*f2*x);
% func2=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f2*x);
% Vin3=@(x) 4*square(2*pi*f3*x);
% func3=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f3*x);
% Vin4=@(x) 4*square(2*pi*f4*x);
% func4=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f4*x);
% --------sawtooth wave-------------------------------
% Vin1=@(x) 4*sawtooth(2*pi*f1*x);
% func1=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f1*x);
% Vin2=@(x) 4*sawtooth(2*pi*f2*x);
% func2=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f2*x);
% Vin3=@(x) 4*sawtooth(2*pi*f3*x);
% func3=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f3*x);
% Vin4=@(x) 4*sawtooth(2*pi*f4*x);
% func4=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f4*x);

[x11,y11]=heun(func1,xi,ii,xf1,h1, Vin1, R)
[x12,y12]=mdp(func1,xi,ii,xf1,h1, Vin1, R)
[x13,y13]=mymethod(func1,xi,ii,xf1,h1,Vin1,R)
[x21,y21]=heun(func2,xi,ii,xf2,h2, Vin2, R)
[x22,y22]=mdp(func2,xi,ii,xf2,h2, Vin2, R)
[x23,y23]=mymethod(func2,xi,ii,xf2,h2,Vin2,R)
[x31,y31]=heun(func3,xi,ii,xf3,h3, Vin3, R)
[x32,y32]=mdp(func3,xi,ii,xf3,h3, Vin3, R)
[x33,y33]=mymethod(func3,xi,ii,xf3,h3,Vin3,R)
[x41,y41]=heun(func4,xi,ii,xf4,h4, Vin4, R)
[x42,y42]=mdp(func4,xi,ii,xf4,h4, Vin4, R)
[x43,y43]=mymethod(func4,xi,ii,xf4,h4,Vin4,R)

subplot(2,2,1)
hold on
plot(x11, y11, '-b','markersize', 3),
plot(x12, y12, '-r','markersize', 1),
plot(x13, y13, '-g','markersize', 1),
hold off
title('T=15us'),
xlim([0, 0.01]),
ylim([-5, 5]),
xlabel('t'), ylabel('Vout');%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,2)
hold on
plot(x21, y21, '*b','markersize', 3),
plot(x22, y22, '*r','markersize', 1),
plot(x23, y23, '*g','markersize', 1),
hold off
title('T=150us'),
xlim([0, 1.6E-4]),
ylim([-5, 5]),
xlabel('t'), ylabel('Vout'),%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,3)
hold on
plot(x31, y31, '*b','markersize', 3),
plot(x32, y32, '*r','markersize', 1),
plot(x33, y33, '*g','markersize', 1),
hold off
title('T=400us'),
xlim([0, 4.2E-4]),
xlabel('t'), ylabel('Vout'),%%%%%%%%%%%%%%%%%%%%%
subplot(2,2,4)
hold on
plot(x41, y41, '*b','markersize', 3),
plot(x42, y42, '*r','markersize', 1),
plot(x43, y43, '*g','markersize', 1),
hold off
title('T=1100us'),
xlim([0, 12E-4]),
xlabel('t'), ylabel('Vout'),%%%%%%%%%%%%%%%%%%%%%

%legend('exact output voltage','approximate solution using Heun method', 'approximate solution using Midpoint method','location', 'northeast'),
%title(['Vout vs t when Vin is a 4V sine signal with T=15us']),
