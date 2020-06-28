clear all, format long e,  
% solving the equation Ly'+Ry=3.5. 
% where y= i, x = t, L=0.0015, R=0.5;  
clear xi yi err yexact N, 

xi=0;
ii=0;
xf=0.1;
R=0.5;
h=0.0008;
Vin=@(x) 3.5;
func=@(x,y) -1000/3*y+7000/3; %function handle: 2 variables specifying for y'= f(x,y)

[x1,y1]=heun(func,xi,ii,xf,h, Vin, R)
[x2,y2]=mdp(func,xi,ii,xf,h, Vin, R)
[x3,y3]=mymethod(func,xi,ii,xf,h,Vin, R)

y_i=7-7*exp(-1000/3*x1); % calculate exact solution at each value of x
Vout= Vin(x1)-0.5*y_i;

hold on
%plot(x1,yexact,'bl', x1,y1,'*r'), grid on, 
plot(x1,Vout,'y'), grid on,
plot(x1, y1, '*b','markersize', 6),
plot(x2, y2, '*r','markersize', 4),
plot(x3, y3, '*g','markersize', 2),
hold off
%xlim([0, 1E-5]),
xlabel('t'), ylabel('Vout'),
legend('exact output voltage','approximate solution using Heun method', 'approximate solution using Midpoint method','approximate solution using My method','location', 'northeast'),
title(['Vout vs t when Vin is a 3.5V step signal']),
%saveas(gcf,['heun1-fix_h'],'jpg'),