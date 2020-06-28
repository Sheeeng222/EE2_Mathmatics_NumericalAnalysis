clear all, format long e,  
% solving the equation Ly'+Ry=3.5. 
% where y= i, x = t, L=0.0015, R=0.5;  
clear xi yi err yexact N, 

xi=0;
ii=0;
xf1=0.03;
h1=0.00003;
xf2=0.003;
h2=0.00003;
R=0.5;
Vin1=@(x) 3.5*exp(-x^2/150E-6);
Vin2=@(x) 3.5*exp(-x/150E-6);
func1=@(x,y) -1000/3*y+(7000/3)*exp(-x^2/150E-6);
func2=@(x,y) -1000/3*y+(7000/3)*exp(-x/150E-6); %function handle: 2 variables specifying for y'= f(x,y)

[x11,y11]=heun(func1,xi,ii,xf1,h1, Vin1, R)
[x12,y12]=mdp(func1,xi,ii,xf1,h1, Vin1, R)
[x13,y13]=mymethod(func1,xi,ii,xf1,h1, Vin1, R)
[x21,y21]=heun(func2,xi,ii,xf2,h2, Vin2, R)
[x22,y22]=mdp(func2,xi,ii,xf2,h2, Vin2, R)
[x23,y23]=mymethod(func2,xi,ii,xf2,h2, Vin2, R)

subplot(2,1,1)
hold on
plot(x11, y11, '*b','markersize', 2),grid on,
plot(x12, y12, '*r','markersize', 1),
plot(x13, y13, '*g','markersize', 1),
hold off
xlim([0, 0.03]),
xlabel('t'), ylabel('Vout'),
legend('approximate solution using Heun method', 'approximate solution using Midpoint method','location', 'northeast'),
title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t^2']),

y_i2=-0.368*exp(-6666.6*x21)+0.368*exp(-333.3*x21); % calculate exact solution at each value of x
vin = 3.5*exp(-x21/150E-6);
Vout2= 3.5*exp(-x21/150E-6)-0.5*y_i2;

subplot(2,1,2);
hold on
plot(x21,Vout2,'g'), grid on,
plot(x21, y21, '*b','markersize', 2),
plot(x22, y22, '*r','markersize', 1),
plot(x23, y23, '*g','markersize', 1),
hold off
xlim([0, 0.003]),
xlabel('t'), ylabel('Vout'),
legend('exact output voltage','approximate solution using Heun method', 'approximate solution using Midpoint method','location', 'northeast'),
title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t']),