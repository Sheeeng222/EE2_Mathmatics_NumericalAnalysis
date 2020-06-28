%----Name: RK2_script------Creater: Sheng Yu-------Date: 03/03/2019------- 
clear all, format long e, 
% clear all variables before running the code;
% and set Floating point format, with 15 digits for double; 7 digits for single;
% in this script, letting y= i, x = t;
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % %------------------------1. Step Input Signal Vin=3.5V---------------------
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % % solving the equation Ly'+Ry=3.5         L = 0.0015, R = 0.5;  
% % % % ---------setting initial conditons and functions----------
xi=0;                             % initial time is 0; 
ii=0;                             % initial current is 0;    
xf=0.1;                           % set the final time to be 0.1, so the interval is [0,0.1];
R=0.5;                            % resistance of the resistor is 0.5;
h=0.0008;                         % the step size is set to be 0.008;
Vin=@(x) 3.5;                     % the input signal is constant(3.5) when t > 0;
func=@(x,y) -1000/3*y+7000/3;     % ODE function handle: 2 variables specifying for y'= f(x,y)
% ---------numerical results: calling three functions----------
[x1,y1]=heun(func,xi,ii,xf,h, Vin, R)     % y1 is a set of numerical results obtained by the Heun's method;
[x2,y2]=mdp(func,xi,ii,xf,h, Vin, R)      % y2 is a set of numerical results obtained by the Midpoint method;
[x3,y3]=mymethod(func,xi,ii,xf,h,Vin, R)  % y3 is a set of numerical results obtained by the MyMethod method;
% ---------exact results: solving the ODE, getting y function----------
y_i=7-7*exp(-1000/3*x1);                  % calculate exact resluts at each value of x
Vout= Vin(x1)-0.5*y_i;                    % since results calculated above are describling the current,
                                          % Vout = Vin - R*I, obtainig exact results for outpout voltage; 
% ---------plotting and comaring----------                                    
hold on                                   % plot all results on the same graph;
plot(x1, Vout,'y'), grid on,              % yellow line represents exact results;
plot(x1, y1, '*b','markersize', 6),       % blue dots represents Heun's results;
plot(x2, y2, '*r','markersize', 4),       % red dots represents Midpoint's results;
plot(x3, y3, '*g','markersize', 2),       % geen dots represents MyMethod results;
hold off                                  % different numerical results have different sizes of dots; 
                                          % so even if they are the same,they would not be totally coverd;
xlim([0, 0.1]),                           % setting x axis of the graph from 0 to 0.1;
xlabel('t'), ylabel('Vout'),              % setting x axis label as t and y axis label as Vout;
legend('exact output voltage','approximate solution using Heun method', ...
    'approximate solution using Midpoint method','approximate solution using MyMethod','location', 'northeast'),
                                          % setting legneds;
title(['Vout vs t when Vin is a 3.5V step signal (t is from 0~0.01) with h=0.0008']), 
                                          % setting the title of the graph;
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % %------------------------2. Impulsive Decaying Signal ---------------------
% % % %-------------------Vin1=3.5exp(-t^2/?) And Vin2=3.5exp(-t/?)--------------
% % % %--------------------------------------------------------------------------  
% % % %-------------------------------------------------------------------------- 
% % % % solving the equation Ly'+Ry=3.5exp(-t^2/?)    L = 0.0015, R = 0.5;
% % % %                  and Ly'+Ry=3.5exp(-t/?)      L = 0.0015, R = 0.5;
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                                               % initial time is 0; 
% % % ii=0;                                               % initial current is 0;
% % % xf1=0.00005;                                           % set the final time of Vin1 to be 0.03;
% % % h1=0.000001;                                          % set the step size of Vin1 to be 0.0003--->100segments;
% % % xf2=0.001;                                          % set the final time of Vin2 to be 0.003;
% % % h2=0.00002;                                         % set the step size of Vin2 to be 0.00003--->100segments;
% % % R=0.5;                                              % resistance of the resistor is 0.5;
% % % Vin1=@(x) 3.5*exp(-x^2/150E-12);                     % the input signal is Vin1=3.5*exp(-x^2/150E-12) when x > 0;
% % % Vin2=@(x) 3.5*exp(-x/150E-6);                       % the input signal is Vin2=3.5*exp(-x/150E-6) when x > 0;
% % % func1=@(x,y) -1000/3*y+(7000/3)*exp(-x^2/150E-12);   % ODE function1 for Vin1: 2 variables specifying for y'= f(x,y);
% % % func2=@(x,y) -1000/3*y+(7000/3)*exp(-x/150E-6);     % ODE function2 for Vin2: 2 variables specifying for y'= f(x,y)
% % % % ---------numerical results: calling three functions for each input voltage----------
% % % [x11,y11]=heun(func1,xi,ii,xf1,h1, Vin1, R)         % y11 is a set of numerical results obtained by the Heun's method for Vin1;
% % % [x12,y12]=mdp(func1,xi,ii,xf1,h1, Vin1, R)          % y12 is a set of numerical results obtained by the Midpoint method for Vin1;
% % % [x13,y13]=mymethod(func1,xi,ii,xf1,h1, Vin1, R)     % y13 is a set o3f numerical results obtained by the MyMethod method for Vin1;
% % % [x21,y21]=heun(func2,xi,ii,xf2,h2, Vin2, R)         % y21 is a set of numerical results obtained by the Heun's method for Vin2;
% % % [x22,y22]=mdp(func2,xi,ii,xf2,h2, Vin2, R)          % y22 is a set of numerical results obtained by the Midpoint method for Vin2;
% % % [x23,y23]=mymethod(func2,xi,ii,xf2,h2, Vin2, R)     % y23 is a set of numerical results obtained by the MyMethod method for Vin2;
% % % % ---------exact results: solving the ODE, getting y function----------
% % % % ---calculate exact solutions for Vin1 at each value of x;
% % % % since it is not possible to find out the exact solution of the integral
% % % % of a exp(-t^2) function, there would be no exact results for Vin1.
% % % % Therefore, using numerical analysis if the only practical way to give results of the Vout accross the inductor in this case; 
% % % % ---calculate exact solutions for Vin2 at each value of x;
% % % y_i2=-0.368*exp(-6666.6*x21)+0.368*exp(-333.3*x21); % solve the ODE get y function, which represents current in this case;  
% % % vin = 3.5*exp(-x21/150E-6);                         % calculate the input voltage;
% % % Vout2= 3.5*exp(-x21/150E-6)-0.5*y_i2;               % Vout = Vin - R*I, obtainig exact results for outpout voltage with Vin1 input; 
% % % % ---------plotting and comaring---------- 
% % % % --------------Vin1 plot-----------------
% % % subplot(2,1,1)                                      % subplot1: ploting Vout1 when Vin1 is applied;
% % % hold on                                             % no exact results in this case;
% % % plot(x11, y11, '*b','markersize', 3),grid on,       % use blue dots to represents numerical results obtained by using Heun's method;
% % % plot(x12, y12, '*r','markersize', 1),               % use red dots to represents numerical results obtained by using Midpoint method;
% % % plot(x13, y13, '*g','markersize', 1),               % use green dots to represents numerical results obtained by using MyMethod method;
% % % hold off                                            % plot numerical results for Vin1 in the same graph;
% % % xlim([0, 0.00005]),                                    % set the x axis, time t from 0~0.03 seconds;
% % % xlabel('t(s)'), ylabel('Vout(V)'),                  % set x axis label t(s), and y axis label Vout(V);
% % % legend('approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %     'approximate solution using MyMethod method','location', 'northeast'),  % set the legend; 
% % % title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t^2']),  % set the title;
% % % % --------------Vin2 plot------------------
% % % subplot(2,1,2);                                     % subplot2: ploting Vout2 when Vin2 is applied;
% % % hold on
% % % plot(x21,Vout2,'-y'), grid on,                      % since the ODE could be solved, we plot the exact results by a yellow line;
% % % plot(x21, y21, '*b','markersize', 3),               % use blue dots to represents numerical results obtained by using Heun's method;
% % % plot(x22, y22, '*r','markersize', 1),               % use red dots to represents numerical results obtained by using Midpoint method;
% % % plot(x23, y23, '*g','markersize', 1),               % use green dots to represents numerical results obtained by using MyMethod method;
% % % hold off                                            
% % % xlim([0, 0.001]),                                   % set the x axis, time t from 0~0.003 seconds;
% % % xlabel('t(s)'), ylabel('Vout(V)'),                        % set x axis label t(s), and y axis label Vout(V);
% % % legend('exact output voltage','approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %     'approximate solution using MyMethod method','location', 'northeast'), % set the legend;
% % % title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t']),    % set the title;
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % %------------------------------3. Period Signal ---------------------------
% % % %------------sine, square, sawtooth; T=15?s, 150?s, 400?s, 1100?s----------
% % % %--------------------------------------------------------------------------  
% % % %-------------------------------------------------------------------------- 
% % % % solving the equation Ly'+Ry=4sin(2*pi*f*x)         L = 0.0015, R = 0.5;
% % % %                  and Ly'+Ry=4square(2*pi*f*x)      L = 0.0015, R = 0.5;
% % % %                  and Ly'+Ry=4sawtooth(2*pi*f*x)    L = 0.0015, R = 0.5;
% % % %                  f = [66666.6, 6666.6, 2500, 909.09];
% % % % ---------setting initial conditons and functions----------
% % % xi=0;              % initial time is 0; 
% % % ii=0;              % initial current is 0;
% % % R=0.5;             % resistance of the resistor is 0.5;
% % % xf1=0.000016;      % when period is 15?s, set the final time to be 16?s;
% % % xf2=0.00016;       % when period is 150?s, set the final time to be 160?s;
% % % xf3=0.00045;       % when period is 400?s, set the final time to be 450?s;
% % % xf4=0.0012;        % when period is 1100?s, set the final time to be 1200?s;
% % %                    % since input period signals have different periods,
% % %                    % their corresponding final times are a bit larger than
% % %                    % their periods, so plots could show features of output
% % %                    % voltages for a full period;
% % % h1=0.0000005;      % when period is 15?s, set the step size to be 0.0000005;
% % % h2=0.000005;       % when period is 150?s, set the step size to be 0.000005;
% % % h3=0.000015;       % when period is 400?s, set the step size to be 0.000015;
% % % h4=0.00004;        % when period is 1100?s, set the step size to be 0.00004;
% % %                    % since final times are different for different periods,
% % %                    % step sizes are also diffeet to make sure there would
% % %                    % be enough amount of segments for numerical analysis.
% % %                    % in this case, the number of segements for each input
% % %                    % signal is about 30;
% % % f1=66666.6;        % when period is 15?s, f1=1/T1=66666.6Hz;
% % % f2=6666.6;         % when period is 150?s, f2=1/T2=6666.6Hz;
% % % f3=2500;           % when period is 400?s, f3=1/T3=2500Hz;
% % % f4=909.09;         % when period is 1100?s, f4=1/T4=909.09Hz;
% % % % ---------numerical results: set ODE functions for each input voltage----------
% % % % ------------------------------sine wave----------------------------------
% % % % -------uncomment following lines to display sine wave results------------
% % % Vin1=@(x) 4*sin(2*pi*f1*x);                             % input voltage1 is 4*sin(2*pi*f1*x); 
% % % func1=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f1*x);         % corresponding ODE function when period is 15?s;
% % % Vin2=@(x) 4*sin(2*pi*f2*x);                             % input voltage2 is 4*sin(2*pi*f2*x); 
% % % func2=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f2*x);         % corresponding ODE function when period is 150?s;
% % % Vin3=@(x) 4*sin(2*pi*f3*x);                             % input voltage3 is 4*sin(2*pi*f3*x); 
% % % func3=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f3*x);         % corresponding ODE function when period is 400?s;
% % % Vin4=@(x) 4*sin(2*pi*f4*x);                             % input voltage4 is 4*sin(2*pi*f4*x); 
% % % func4=@(x,y) -1000/3*y+(8000/3)*sin(2*pi*f4*x);         % corresponding ODE function when period is 1100?s;
% % % % ------------------------------square wave--------------------------------
% % % % -------uncomment following lines to display square wave results----------
% % % Vin1=@(x) 4*square(2*pi*f1*x);                        % input voltage1 is 4*square(2*pi*f1*x);
% % % func1=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f1*x);    % corresponding ODE function when period is 15?s;
% % % Vin2=@(x) 4*square(2*pi*f2*x);                        % input voltage2 is 4*square(2*pi*f2*x); 
% % % func2=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f2*x);    % corresponding ODE function when period is 150?s;
% % % Vin3=@(x) 4*square(2*pi*f3*x);                        % input voltage3 is 4*square(2*pi*f3*x);
% % % func3=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f3*x);    % corresponding ODE function when period is 400?s;
% % % Vin4=@(x) 4*square(2*pi*f4*x);                        % input voltage4 is 4*square(2*pi*f4*x); 
% % % func4=@(x,y) -1000/3*y+(8000/3)*square(2*pi*f4*x);    % corresponding ODE function when period is 1100?s;
% % % % -----------------------------sawtooth wave-------------------------------
% % % % -------uncomment following lines to display sawtooth wave results--------
% % % Vin1=@(x) 4*sawtooth(2*pi*f1*x);                      % input voltage1 is 4*sawtooth(2*pi*f1*x);
% % % func1=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f1*x);  % corresponding ODE function when period is 15?s;
% % % Vin2=@(x) 4*sawtooth(2*pi*f2*x);                      % input voltage2 is 4*sawtooth(2*pi*f2*x); 
% % % func2=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f2*x);  % corresponding ODE function when period is 150?s;
% % % Vin3=@(x) 4*sawtooth(2*pi*f3*x);                      % input voltage3 is 4*sawtooth(2*pi*f3*x);
% % % func3=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f3*x);  % corresponding ODE function when period is 400?s;
% % % Vin4=@(x) 4*sawtooth(2*pi*f4*x);                      % input voltage4 is 4*sawtooth(2*pi*f4*x); 
% % % func4=@(x,y) -1000/3*y+(8000/3)*sawtooth(2*pi*f4*x);  % corresponding ODE function when period is 1100?s;
% % % % ---------numerical results: calling three functions for each input voltage----------
% % % [x11,y11]=heun(func1,xi,ii,xf1,h1, Vin1, R)             % y11 is a set of numerical results obtained by the Heun's method when period is 15?s;
% % % [x12,y12]=mdp(func1,xi,ii,xf1,h1, Vin1, R)              % y12 is a set of numerical results obtained by the Midpoint method when period is 15?s;
% % % [x13,y13]=mymethod(func1,xi,ii,xf1,h1,Vin1,R)           % y13 is a set of numerical results obtained by the MyMethod method when period is 15?s;
% % % [x21,y21]=heun(func2,xi,ii,xf2,h2, Vin2, R)             % y21 is a set of numerical results obtained by the Heun's method when period is 150?s;
% % % [x22,y22]=mdp(func2,xi,ii,xf2,h2, Vin2, R)              % y22 is a set of numerical results obtained by the Midpoint method when period is 150?s;
% % % [x23,y23]=mymethod(func2,xi,ii,xf2,h2,Vin2,R)           % y23 is a set of numerical results obtained by the MyMethod method when period is 150?s;
% % % [x31,y31]=heun(func3,xi,ii,xf3,h3, Vin3, R)             % y31 is a set of numerical results obtained by the Heun's method when period is 400?s;
% % % [x32,y32]=mdp(func3,xi,ii,xf3,h3, Vin3, R)              % y32 is a set of numerical results obtained by the Midpoint method when period is 400?s;
% % % [x33,y33]=mymethod(func3,xi,ii,xf3,h3,Vin3,R)           % y33 is a set of numerical results obtained by the MyMethod method when period is 400?s;
% % % [x41,y41]=heun(func4,xi,ii,xf4,h4, Vin4, R)             % y41 is a set of numerical results obtained by the Heun's method when period is 1100?s;
% % % [x42,y42]=mdp(func4,xi,ii,xf4,h4, Vin4, R)              % y42 is a set of numerical results obtained by the Midpoint method when period is 1100?s;
% % % [x43,y43]=mymethod(func4,xi,ii,xf4,h4,Vin4,R)           % y43 is a set of numerical results obtained by the MyMethod method when period is 1100?s;
% % % % ------------------------plotting and comaring---------------------------- 
% % % % for three input signals: sine, square, sawtooth, only the ODE with sine wave could be
% % % % solved and get exact solutions;
% % % % we use four subplots to display the sine/square/sawtooth waves with
% % % % different periods;
% % % subplot(2,2,1)                        % subplot1, when period is 15?s;
% % % hold on
% % % plot(x11, y11, '*b','markersize', 3), % blue dots represents numerical results obtained by using Heun's method;
% % % plot(x12, y12, '*r','markersize', 1), % red dots represents numerical results obtained by using Midpoint method;
% % % plot(x13, y13, '*g','markersize', 1), % green dots represents numerical results obtained by using MyMmethod;
% % % hold off
% % % title('Vout vs Vin with T=15us'),     % set the title when period is 15?s;
% % % xlim([0, 1.6E-5]),                    % set the x axis limit, covering one period; 
% % % ylim([-5, 5]),                        % set the y axis limit, covering the peak to peak voltage;
% % % xlabel('t'), ylabel('Vout');          % set labels for axises;
% % % legend('approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %  'approximate solution using MyMethod''location', 'northeast'),  % set the legend;
% % % 
% % % subplot(2,2,2)                        % subplot2, when period is 150?s;
% % % hold on
% % % plot(x21, y21, '*b','markersize', 3), % blue dots represents numerical results obtained by using Heun's method;
% % % plot(x22, y22, '*r','markersize', 1), % red dots represents numerical results obtained by using Midpoint method;
% % % plot(x23, y23, '*g','markersize', 1), % green dots represents numerical results obtained by using MyMmethod;
% % % hold off 
% % % title('Vout vs Vin with T=150us'),    % set the title when period is 150?s;
% % % xlim([0, 1.6E-4]),                    % set the x axis limit, covering one period; 
% % % ylim([-5, 5]),                        % set the y axis limit, covering the peak to peak voltage;
% % % xlabel('t'), ylabel('Vout'),          % set labels for axises;
% % % legend('approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %     'approximate solution using MyMethod''location', 'northeast'),  % set the legend;
% % % 
% % % subplot(2,2,3)                        % subplot3, when period is 400?s;
% % % hold on
% % % plot(x31, y31, '*b','markersize', 3), % blue dots represents numerical results obtained by using Heun's method;
% % % plot(x32, y32, '*r','markersize', 1), % red dots represents numerical results obtained by using Midpoint method;
% % % plot(x33, y33, '*g','markersize', 1), % green dots represents numerical results obtained by using MyMmethod;
% % % hold off
% % % title('Vout vs Vin with T=400us'),    % set the title when period is 400?s;
% % % xlim([0, 4.2E-4]),                    % set the x axis limit, covering one period; 
% % % ylim([-5, 5]),                        % set the y axis limit, covering the peak to peak voltage;
% % % xlabel('t'), ylabel('Vout'),          % set labels for axises;
% % % legend('approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %     'approximate solution using MyMethod''location', 'northeast'),  % set the legend;
% % % 
% % % subplot(2,2,4)                        % subplot4, when period is 1100?s;
% % % hold on
% % % plot(x41, y41, '*b','markersize', 3), % blue dots represents numerical results obtained by using Heun's method;
% % % plot(x42, y42, '*r','markersize', 1), % red dots represents numerical results obtained by using Midpoint method;
% % % plot(x43, y43, '*g','markersize', 1), % green dots represents numerical results obtained by using MyMmethod;
% % % hold off
% % % title('Vout vs Vin with T=1100us'),   % set the title when period is 1100?s;
% % % xlim([0, 12E-4]),                     % set the x axis limit, covering one period; 
% % % ylim([-5, 5]),                        % set the y axis limit, covering the peak to peak voltage;
% % % xlabel('t'), ylabel('Vout'),          % set labels for axises;
% % % legend('approximate solution using Heun method', 'approximate solution using Midpoint method',...
% % %     'approximate solution using MyMethod''location', 'northeast'),  % set the legend;
% % % %--------------------------------------------------------------------------
% % % %--------------------------------------------------------------------------
% % % %-----------------------------4. Open End Tests ---------------------------
% % % %-------------------------varying R, L, i(0), tao, T, Vin, ----------------
% % % %--------------------------------------------------------------------------  
% % % %-------------------------------------------------------------------------- 
% % % % ----4.1 varying Resistance R---------------------------------------
% % % % solving the equation Ly'+Ry=3.5exp(-t^2/tao)         L = 0.0015, R varies;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii=0;                             % initial current is 0;    
% % % xf=0.0002;                        % set the final time to be 0.1, so the interval is [0,0.1];
% % % L = 0.0015;                       % set the inductance to be 0.0015;
% % % R0=0.5;   % % % % % % % R0=0.5;
% % % R1=200;% % % % % % % R1=20;                          
% % % R2=1000;% % % % % % % R2=50;                           
% % % R3=2700;% % % % % % % R3=100;                         
% % % R4=2900;% % % % % % % R4=200;                           
% % % R5=2970;% % % % % % % R5=400;                            
% % % R6=2990;% % % % % % % R6=500;
% % % R7=3000;
% % % h=0.000001;                       % the step size is set to be 0.000001;
% % % Vin=@(x) 3.5*exp(-x^2/150E-12);                     % the input signal is constant(3.5) when t > 0;
% % % func0=@(x,y) -R0/L*y+3.5/L*exp(-x^2/150E-12); 
% % % func1=@(x,y) -R1/L*y+3.5/L*exp(-x^2/150E-12);       % ODE function handle: 2 variables specifying for y'= f(x,y)
% % % func2=@(x,y) -R2/L*y+3.5/L*exp(-x^2/150E-12);
% % % func3=@(x,y) -R3/L*y+3.5/L*exp(-x^2/150E-12);
% % % func4=@(x,y) -R4/L*y+3.5/L*exp(-x^2/150E-12);
% % % func5=@(x,y) -R5/L*y+3.5/L*exp(-x^2/150E-12);
% % % func6=@(x,y) -R6/L*y+3.5/L*exp(-x^2/150E-12);
% % % func7=@(x,y) -R7/L*y+3.5/L*exp(-x^2/150E-12);
% % % % ---------numerical results: calling MyMethod function for different resistances----------
% % % [x0,y0]=mymethod(func0,xi,ii,xf,h, Vin, R0);    
% % % [x1,y1]=mymethod(func1,xi,ii,xf,h, Vin, R1);    
% % % [x2,y2]=mymethod(func2,xi,ii,xf,h, Vin, R2);    
% % % [x3,y3]=mymethod(func3,xi,ii,xf,h, Vin, R3);    
% % % [x4,y4]=mymethod(func4,xi,ii,xf,h, Vin, R4);    
% % % [x5,y5]=mymethod(func5,xi,ii,xf,h, Vin, R5);    
% % % [x6,y6]=mymethod(func6,xi,ii,xf,h, Vin, R6);
% % % [x7,y7]=mymethod(func7,xi,ii,xf,h, Vin, R7);
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % plot(x0, y0, '-k','markersize', 3), grid on
% % % plot(x1, y1, '-b','markersize', 3),             % blue dots represents R=0.05;
% % % plot(x2, y2, 'Color','[0.5 0.5 0.5]','markersize', 3),             % red dots represents R=0.5;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents R=0.1;
% % % plot(x4, y4, '-y','markersize', 3),             % yellow dots represents R=0.15;
% % % plot(x5, y5, '-m','markersize', 3),             % purple dots represents R=10;
% % % plot(x6, y6, '-c','markersize', 3),             % cyan dots represents R=10;
% % % plot(x7, y7, '-r','markersize', 3),             % cyan dots represents R=10;
% % % hold off                                  
% % % xlim([0, 0.0002]),                                 % setting x axis of the graph from 0 to 0.1;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution R=0.05','approximate solution R=200', ...
% % %     'approximate solution R=1000','approximate solution R=2500',...
% % %     'approximate solution R=2900','approximate solution R=2970','approximate solution R=2990','approximate solution R=3000','location', 'northeast'),
% % %                                           % setting legneds;
% % % title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t^2, for different Resistances']), 
% % %                                           % setting the title of the graph;
% % % % ----4.2 varying Inductance R----------------------------------------------
% % % % solving the equation Ly'+Ry=3.5         R = 0.5, L varies;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii=0;                             % initial current is 0;    
% % % xf=0.1;                           % set the final time to be 0.1, so the interval is [0,0.1];
% % % R = 0.5;                          % set the resistance to be 0.5;
% % % L1=0.0015;                        % inductance1 of the resistor is 0.0015;
% % % L2=0.005;                         % inductance2 of the resistor is 0.005;
% % % L3=0.015;                         % inductance3 of the resistor is 0.015;
% % % L4=0.02;                          % inductance4 of the resistor is 0.02;
% % % L5=0.03;                          % inductance5 of the resistor is 0.03;
% % % h=0.0008;                         % the step size is set to be 0.008;
% % % Vin=@(x) 3.5;                     % the input signal is constant(3.5) when t > 0;
% % % func1=@(x,y) -R/L1*y+3.5/L1;      % ODE function handle: 2 variables specifying for y'= f(x,y)
% % % func2=@(x,y) -R/L2*y+3.5/L2;
% % % func3=@(x,y) -R/L3*y+3.5/L3;
% % % func4=@(x,y) -R/L4*y+3.5/L4;
% % % func5=@(x,y) -R/L5*y+3.5/L5;
% % % % ---------numerical results: calling MyMethod function for different resistances----------
% % % [x1,y1]=mymethod(func1,xi,ii,xf,h, Vin, R)     % y1 is a set of numerical results when L = 0.0015;
% % % [x2,y2]=mymethod(func2,xi,ii,xf,h, Vin, R)     % y2 is a set of numerical results when L = 0.005;
% % % [x3,y3]=mymethod(func3,xi,ii,xf,h, Vin, R)     % y3 is a set of numerical results when L = 0.015;
% % % [x4,y4]=mymethod(func4,xi,ii,xf,h, Vin, R)     % y4 is a set of numerical results when L = 0.02;
% % % [x5,y5]=mymethod(func5,xi,ii,xf,h, Vin, R)     % y5 is a set of numerical results when L = 0.03;
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % plot(x1, y1, '-b','markersize', 3), grid on     % blue dots represents L = 0.0015;
% % % plot(x2, y2, '-r','markersize', 3),             % red dots represents L = 0.005;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents L = 0.015;
% % % plot(x4, y4, '-y','markersize', 3),             % yellow dots represents L = 0.02;
% % % plot(x5, y5, '-m','markersize', 3),             % purple dots represents L = 0.03;
% % % hold off                                  
% % % xlim([0, 0.1]),                                 % setting x axis of the graph from 0 to 0.1;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution L = 0.0015','approximate solution L = 0.005', ...
% % %     'approximate solution L = 0.015','approximate solution L = 0.2','approximate solution L = 0.3','location', 'northeast'),
% % %                                           % setting legneds;
% % % title(['Vout vs t when Vin is a 3.5V step signal (t is from 0~0.01) with h=0.0008, for different Inductances']), 
% % %                                           % setting the title of the graph;
% % % % ----4.3 varying Initial Current i(0)-------------------------------------
% % % % solving the equation Ly'+Ry=3.5         R = 0.5, L 0.0015;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii1=0;                            % initial current is 0;
% % % ii2=1;                            % initial current is 1;
% % % ii3=5;                            % initial current is 5;
% % % ii4=6;                            % initial current is 6;
% % % ii5=7;                            % initial current is 7;
% % % ii6=8;                            % initial current is 8;
% % % ii7=10;                           % initial current is 10;
% % % xf=0.02;                          % set the final time to be 0.02, so the interval is [0,0.02];
% % % R = 0.5;                          % set the resistance to be 0.5;
% % % L=0.0015;                         % inductance of the resistor is 0.00015;
% % % h=0.00008;                        % the step size is set to be 0.0008;
% % % Vin=@(x) 3.5;                     % the input signal is constant(3.5) when t > 0;
% % % func=@(x,y) -R/L*y+3.5/L;        % ODE function handle: 2 variables specifying for y'= f(x,y)
% % % % ---------numerical results: calling MyMethod function for different resistances----------
% % % [x1,y1]=mymethod(func,xi,ii1,xf,h, Vin, R)     % y1 is a set of numerical results when ii1 = 0;
% % % [x2,y2]=mymethod(func,xi,ii2,xf,h, Vin, R)     % y2 is a set of numerical results when ii2 = 1
% % % [x3,y3]=mymethod(func,xi,ii3,xf,h, Vin, R)     % y3 is a set of numerical results when ii3 = 5;
% % % [x4,y4]=mymethod(func,xi,ii4,xf,h, Vin, R)     % y4 is a set of numerical results when ii4 = 6;
% % % [x5,y5]=mymethod(func,xi,ii5,xf,h, Vin, R)     % y5 is a set of numerical results when ii5 = 7;
% % % [x6,y6]=mymethod(func,xi,ii6,xf,h, Vin, R)     % y6 is a set of numerical results when ii5 = 8;
% % % [x7,y7]=mymethod(func,xi,ii7,xf,h, Vin, R)     % y7 is a set of numerical results when ii5 = 10;
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % plot(x1, y1, '-b','markersize', 3), grid on     % blue dots represents ii1 = 0;
% % % plot(x2, y2, '-r','markersize', 3),             % red dots represents ii2 = 1;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents ii3 = 5;
% % % plot(x4, y4, '-y','markersize', 3),             % yellow dots represents ii4 = 6;
% % % plot(x5, y5, '-m','markersize', 3),             % purple dots represents ii5 = 7;
% % % plot(x6, y6, '-k','markersize', 3),             % black dots represents ii6 = 8;
% % % plot(x7, y7, '-c','markersize', 3),             % cyan dots represents ii7 = 10;
% % % hold off                                  
% % % xlim([0, 0.02]),                                % setting x axis of the graph from 0 to 0.1;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution initial current = 0','approximate solution initial current = 1', ...
% % %     'approximate solution initial current = 5','approximate solution initial current = 6',...
% % %     'approximate solution initial current = 7','approximate solution initial current = 8',...
% % %     'approximate solution initial current = 10','location', 'northeast'),
% % %                                           % setting legneds;
% % % title(['Vout vs t when Vin is a 3.5V step signal (t is from 0~0.02) with h=0.0008, for different initial currents']), 
% % %                                           % setting the title of the graph;
% % % % ----4.4 varying time constant---------------------------------------
% % % % solving the equation Ly'+Ry=3.5exp(-t^2/tao)         L = 0.0015, R =0.5;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii=0;                             % initial current is 0;    
% % % xf=0.00005;                       % set the final time to be 0.1, so the interval is [0,0.1];
% % % L = 0.0015;                       % set the inductance to be 0.0015;
% % % R=0.5;                            % resistance of the resistor is 0.5;
% % % h=0.000001;                       % the step size is set to be 0.000001;
% % % tao1=500E-14;                     % time constant1 is 500E-14;
% % % tao2=500E-13;                     % time constant2 is 500E-13;
% % % tao3=150E-12;                     % time constant3 is 150E-12;
% % % tao4=300E-12;                     % time constant4 is 300E-12;
% % % tao5=500E-12;                     % time constant5 is 500E-12;
% % % Vin1=@(x) 3.5*exp(-x^2/tao1);                     % the input signal  when t > 0;
% % % Vin2=@(x) 3.5*exp(-x^2/tao2); 
% % % Vin3=@(x) 3.5*exp(-x^2/tao3); 
% % % Vin4=@(x) 3.5*exp(-x^2/tao4); 
% % % Vin5=@(x) 3.5*exp(-x^2/tao5); 
% % % func1=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao1);       % ODE function handle: 2 variables specifying for y'= f(x,y)
% % % func2=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao1);
% % % func3=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao1);
% % % func4=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao1);
% % % func5=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao1);
% % % % ---------numerical results: calling MyMethod function for different resistances----------
% % % [x1,y1]=mymethod(func1,xi,ii,xf,h, Vin1, R)     % y1 is a set of numerical results when time constant1 is 500E-14;
% % % [x2,y2]=mymethod(func2,xi,ii,xf,h, Vin2, R)     % y2 is a set of numerical results when time constant2 is 500E-13;
% % % [x3,y3]=mymethod(func3,xi,ii,xf,h, Vin3, R)     % y3 is a set of numerical results when time constant3 is 150E-12;
% % % [x4,y4]=mymethod(func4,xi,ii,xf,h, Vin4, R)     % y4 is a set of numerical results when time constant4 is 300E-12;
% % % [x5,y5]=mymethod(func5,xi,ii,xf,h, Vin5, R)     % y5 is a set of numerical results when time constant5 is 500E-12;
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % plot(x1, y1, '-b','markersize', 3), grid on     % blue dots represents time constant1 is 500E-14;
% % % plot(x2, y2, '-r','markersize', 3),             % red dots represents time constant2 is 500E-13;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents time constant3 is 150E-12;
% % % plot(x4, y4, '-y','markersize', 3),             % yellow dots represents time constant4 is 300E-12;
% % % plot(x5, y5, '-m','markersize', 3),             % purple dots represents time constant5 is 500E-12;
% % % hold off                                  
% % % xlim([0, 0.00005]),                             % setting x axis of the graph from 0 to 0.00005;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution time constant = 500E-14','approximate solution time constant = 500E-13', ...
% % %     'approximate solution time constant = 150E-12','approximate solution time constant = 300E-12',...
% % %     'approximate solution time constant = 500E-12','location', 'northeast'),
% % %                                           % setting legneds;
% % % title(['Vout vs t when Vin is a 3.5V inpulse signal decaying t^2, for different time constants']), 
% % %                                           % setting the title of the graph;
% % % % ----4.5 varying periods--------------------------------------
% % % % solving the equation Ly'+Ry=4*square?2*pi*f*x)         L = 0.0015, R =0.5;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii=0;                             % initial current is 0;    
% % % xf=0.05;                         % set the final time to be 0.0035, so the interval is [0,0.0035];
% % % L = 0.0015;                       % set the inductance to be 0.0015;
% % % R=0.5;                            % resistance of the resistor is 0.5;
% % % h=0.00001;                        % the step size is set to be 0.000001;
% % % f1=1000;
% % % f2=500;
% % % f3=250;
% % % Vin1=@(x) 4*square(2*pi*f1*x);                  % input voltage1 is 4*square(2*pi*f1*x);
% % % func1=@(x,y) -R/L*y+4/L*square(2*pi*f1*x);      % corresponding ODE function when period is 0.001s, frequency is 1000Hz;
% % % Vin2=@(x) 4*square(2*pi*f2*x);                  % input voltage2 is 4*square(2*pi*f2*x); 
% % % func2=@(x,y) -R/L*y+4/L*square(2*pi*f2*x);      % corresponding ODE function when period is 0.002s, frequency is 500Hz;
% % % Vin3=@(x) 4*square(2*pi*f3*x);                  % input voltage3 is 4*square(2*pi*f3*x);
% % % func3=@(x,y) -R/L*y+4/L*square(2*pi*f3*x);      % corresponding ODE function when period is 0.004s, frequency is 250Hz;
% % % [x1,y1]=mymethod(func1,xi,ii,xf,h, Vin1, R);    % y1 is a set of numerical results when period is 0.001s, frequency is 1000Hz;
% % % [x2,y2]=mymethod(func2,xi,ii,xf,h, Vin2, R);    % y2 is a set of numerical results when period is 0.002s, frequency is 500Hz;
% % % [x3,y3]=mymethod(func3,xi,ii,xf,h, Vin3, R);    % y3 is a set of numerical results when period is 0.004s, frequency is 250Hz;
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % %plot(x1, y1, '-b','markersize', 3), grid on     % blue dots represents period is 0.001s, frequency is 1000Hz;
% % % %plot(x2, y2, '-r','markersize', 3),             % red dots represents period is 0.002s, frequency is 500Hz;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents period is 0.004s, frequency is 250Hz;
% % % hold off                                  
% % % xlim([0, 0.05]),                             % setting x axis of the graph from 0 to 0.00005;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution T=0.001s, f=1000Hz','approximate solution T=0.002s, f=500Hz', ...
% % %     'approximate solution T=0.004s, f=250Hz','location', 'southeast'), % setting legneds;
% % % title(['Vout vs t when Vin is a 4V square wave signal, for different periods']), 
% % %                                           % setting the title of the graph;
% % % % ----4.6 different input voltages-----------------------------------
% % % % solving the equation Ly'+Ry=3.5exp(-t^3/tao)         L = 0.0015, R =0.5;  
% % % % ---------setting initial conditons and functions----------
% % % xi=0;                             % initial time is 0; 
% % % ii=0;                             % initial current is 0;    
% % % xf=0.02;                          % set the final time to be 0.02, so the interval is [0,0.02];
% % % L = 0.0015;                       % set the inductance to be 0.0015;
% % % R=0.5;                            % resistance of the resistor is 0.5;
% % % h=0.0001;                         % the step size is set to be 0.0001;
% % % tao=150E-12;                      % time constant3 is 150E-12;
% % % Vin1=@(x) 3.5*exp(-x^2/tao);                     % the input signal  decaying -x^2;
% % % Vin2=@(x) 3.5*exp(-x^3/tao);                     % the input signal  decaying -x^3;
% % % Vin3=@(x) 3.5*exp(-x^4/tao);                     % the input signal  decaying -x^4;
% % % func1=@(x,y) -R/L*y+3.5/L*exp(-x^2/tao);         % ODE function handle: 2 variables specifying for y'= f(x,y)
% % % func2=@(x,y) -R/L*y+3.5/L*exp(-x^3/tao);
% % % func3=@(x,y) -R/L*y+3.5/L*exp(-x^4/tao);
% % % % ---------numerical results: calling MyMethod function for different resistances----------
% % % [x1,y1]=mymethod(func1,xi,ii,xf,h, Vin1, R);    % y1 is a set of numerical results when input signal  decaying -x^2;
% % % [x2,y2]=mymethod(func2,xi,ii,xf,h, Vin2, R);    % y2 is a set of numerical results when input signal  decaying -x^3;
% % % [x3,y3]=mymethod(func3,xi,ii,xf,h, Vin3, R);    % y3 is a set of numerical results when input signal  decaying -x^4;
% % % % ---------plotting and comaring----------                                    
% % % hold on                                         % plot all results on the same graph;
% % % plot(x1, y1, '-b','markersize', 3), grid on     % blue dots represents input signal  decaying -x^2;
% % % plot(x2, y2, '-r','markersize', 3),             % red dots represents input signal  decaying -x^3;
% % % plot(x3, y3, '-g','markersize', 3),             % geen dots represents input signal  decaying -x^4;
% % % hold off                                  
% % % xlim([0, 0.02]),                                % setting x axis of the graph from 0 to 0.02;
% % % xlabel('t'), ylabel('Vout'),                    % setting x axis label as t and y axis label as Vout;
% % % legend('approximate solution input signal  decaying -x^1','approximate solution input signal  decaying -x^2',...
% % %     'approximate solution input signal  decaying -x^3','location', 'northeast'),
% % %                                           % setting legneds;
% % % title(['Vout vs t when Vin is a 3.5V inpulse signal decaying at -t^2,-t^3 and -t^4']), 
% % %                                           % setting the title of the graph;

