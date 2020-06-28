%----Name: error_script------Creater: Sheng Yu-------Date: 03/03/2019-------
clear all, format long e, 
% In this code, we aim to compare the analytical (exact solution) 
% and the numerical (approximate solution). This code describes the Heun's method, Midpoint and MyMethod for 
% solving the equation y' = f(x,y) = 6cos(2*pi*f*x), f= 6666.6Hz; 
% the ultimate goal of this code is to show the effect of the stepsize h on the 
% maximum absolute value of the difference between the exact and approximate
% solutions. 
% --------------------initialize step sizes to be evaluated-----------------
huse_mym=[5E-8,5E-7,5E-6, 7E-6,10E-6,5E-5, 7E-5, 5E-4,7E-4];  % setting array of step sizes to use;
                                                % for this cosine input signal, its period is 150?s=0.00015?s=1.5E-4;
                                                % we predict error would increasing as the step size increases from 5E-8 to 5E-3; 
% -------using a for loop to obtain results for each step size ------------
for k=1:length(huse_mym),                       % a for loop is used to obtain erroe and maxerror for different step size;            
clear x1 x2 x3 y1 y2 y3  yexact N,              % before each loop, we clear numerical results; 
% ----------------------------initialize parameters------------------------
xi=0;                                           % start time is 0;
yi=0;                                           % initila current is 0;
xf=0.01;                                        % final time is 0.05, for each step size, segments are[10E7, 10E6, 10E5, 10E4, 10E3, 10E2, 11];
R=0.5;                                          % resistance for the resistor is 0.5;
f=6666.6;                                       % frequency is f=1/T=1/150?s=6666.6Hz;
%h_mym=5E-7                                    % step size for error function of time
h_mym=huse_mym(k);                              % for each loop, step size is obtianed from the step size array set at the beginning of the code;
% ----------------------------numerical analysisi--------------------------
VIN=@(x) 6*cos(2*pi*f*x);                       % function of input voltage;           
func=@(x,y) -1000/3*y+4000*cos(2*pi*f*x);       % ODE function to be called; L = 0.0015, R = 0.5 unchanged;
[x1,y1]=heun(func,xi,yi,xf,h_mym,VIN,R);        % y1 is a set of numerical results obtained by calling the Heun's method;
[x2,y2]=mdp(func,xi,yi,xf,h_mym,VIN,R);         % y2 is a set of numerical results obtained by calling the Midpoint method;
[x3,y3]=mymethod(func,xi,yi,xf,h_mym,VIN,R);    % y3 is a set of numerical results obtained by calling the MyMethod method;
% ------------------------------exact analysisi----------------------------
vin=6*cos(2*pi*f*x2);                           % exact input voltage;
iexact=18000*pi*f*sin(2*pi*f*x1)/((3*pi*f)^2+250000)+3000000*cos(2*pi*f*x1)/((3*pi*f)^2+250000)-7.6E-4*exp(-333.33*x1); 
                                                % by solving the ODE obtianed the exact current solution; 
yexact=vin-0.5*iexact;                          % exact ouput voltage is input voltage - voltage across the resistor;
                                                % Vout=Vin-i*R;
% ------------------------------error analysis-----------------------------
err1=yexact-y1;                                 % err1: array containing differences between exact and approximate solutions obtianed by Heun's Method;
err2=yexact-y2;                                 % err2: array containing differences between exact and approximate solutions obtianed by Midpoint Method;
err3=yexact-y3;                                 % err3: array containing differences between exact and approximate solutions obtianed by MyMethod Method;
maxerr1(k)=max(abs(err1));                      % take the maximum difference between exact and Heun's result for each step size;  
maxerr2(k)=max(abs(err2));                      % take the maximum difference between exact and Midpoint's result for each step size; 
maxerr3(k)=max(abs(err3));                      % take the maximum difference between exact and MyMethod's result for each step size; 
                                                % max(abs(x)) function is to take the maximum value of the abuse value of variable x;
end;                                            % end of the for loop;
% ------------------------------graph plotting-----------------------------
% %-------------error as a function of time, with time step h=5E-7---------
% vinn=vin*5E-7;                                % scale the input signal; 
% plot(x1,abs(err1),'-r', x2,abs(err2),'-b', x3,abs(err3),'-g'), grid on; 
% xlim([0,0.0005]);
% xlabel('time'), ylabel('abs(error)');              % set labels for axises;
% legend('error obtained by Heun Method ','error obtained by Midpoint Method',...
%      'error obtained by MyMethod Method','input signal','location', 'northwest');   % set the legend;
% title(['abs(error) as a functionof time']),        % set the title;
% %--------------------the order of error as a function step size h---------
loglog(huse_mym,maxerr1,'-r',huse_mym,maxerr2,'-b',huse_mym,maxerr3,'-g'), grid on;
xlabel('step size h'), ylabel('max(abs(error))');           % set labels for axises;
legend('maximum absolute error obtained by Heun Method ','maximum absolute error obtained by Midpoint Method',...
    'maximum absolute error obtained by MyMethod Method(p=2/3)','location', 'northwest');   % set the legend;
title(['orders of errors for different step sizes']),       % set the title;
% % % a log-log graph to show the order of errors obtianed by different
% % % numerical methods for each step size;
% % % red line represents results obtianed by using Heun's Method;
% % % blue line represents results obtianed by using Midpoint Method;
% % % green line represents results obtianed by using MyMethod Method;

