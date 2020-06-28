function [t,vout]=heun(func,ti,ii,tf,h,vin,r) % a=1/2, b=1/2, p=q=1;
% func is ODE function;                       % ti,tf are initial and final time;      
% ii is the initial current;                  % h is the step size;                       
% vin is the input voltahe;                   % r is the resistor;
%--------initilization--------------------------------------         
t(1)=ti;                                      % set initial value of x xi;  
li(1)=ii;                                     % set initial value of y yi;
vout(1)= vin(ti);                             % set initial valye of output voltage;
N=round((tf-ti)/h);                           % number of steps = (interval size)/(step size);
%--------calculating----------------------------------------
for i=1:N                                     % loop for N steps;
t(i+1)=t(i)+h;                                % next value of x;
yp(i+1) = li(i) + h*feval(func,t(i),li(i));   % predictor for next value of y;

grad1 = feval(func,t(i),li(i));               % gradient at x;
grad2 = feval(func,t(i+1),yp(i+1));           % gradient at x+h;
yave = 0.5*(grad1+grad2);                     % average gradient over [x,x+h];
li(i+1) = li(i) + h*yave;                     % new y from heun, using yave as gradient;

vinn = feval(vin,t(i+1));                     % evaluate input voltage at x+1;
vout(i+1) = vinn-r*li(i+1);                   % evaluate output voltage at x+1;
  
end
end



